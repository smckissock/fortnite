'use strict';

let playerDim;
let playerStatsGroup;

let playerTable;

let playerColors;

let filters = {
    week: "",
    region: "",
    search: "",
    playerCount: 0
}


d3.json('FortniteWorldCup/data/data.json').then(function (data)  {
    data.forEach(function (d) {
        d.rank = +d.rank;
        d.payout = +d.payout;
        d.points = d.points;
    });
    const facts = crossfilter(data);
    draw(facts);

    d3.select("#search-input").on('keyup', function (event) {
        const searchTerm = document.getElementById("search-input").value;
        //console.log(searchTerm);
        //console.group(playerDim.top(10000).length);
        //console.log(playerStatsGroup.all().length);

        filters.search = searchTerm; 
        playerDim.filter(function (d) { 
            return d.toLowerCase().indexOf(searchTerm) !== -1;
        });
        
        updateCounts();
        dc.redrawAll();
    });
});


function updateCounts() {
    makePlayerStatsGroup(playerDim);
    
    const searches = filters.region + " " + filters.week + " " + filters.search + " " + filters.playerCount + " players";  

    d3.select("#count-box")
        .text(searches);
        //.text(playerDim.top(10000).length);
}

function draw(facts) {

    playerDim = facts.dimension(dc.pluck("player"));
    makePlayerColors();

    makePlayerStatsGroup(playerDim);

    playerTable = dc.tableChart("#dc-chart-player", null, playerDim);
    playerTable
        .width(768)
        .height(480)
        .showSections(false)
        .size(Infinity)
        .dimension(playerStatsGroup)
        .columns([function (d) { return d.key },
              function (d) { return d.value.payout },
              function (d) { return d.value.points },
              function (d) { return d.value.wins },
              function (d) { return d.value.elims }])
        .sortBy(function (d) { return d })
        .order(d3.descending);

    const dim = facts.dimension(dc.pluck("region"));
    const group = dim.group().reduceSum(dc.pluck("payout"));

    const weekDim = facts.dimension(dc.pluck("week"));
    const weekPayoutGroup = weekDim.group().reduceSum(dc.pluck("payout"));

    weekChart("#dc-chart-weeks")
        .dimension(weekDim)
        .group(weekPayoutGroup);      
        
    regionChart("#dc-chart-region")
        .dimension(dim)
        .group(group);          

/*     const select = dc.pickChart('#dc-chart-region')
        .dimension(dim)
        .group(group)
        .order(function (a,b) {
            return a.value > b.value ? 1 : b.value > a.value ? -1 : 0;
        });
    // the option text can be set via the title() function
    // by default the option text is '`key`: `value`'
    select.title(function (d){
        return d.key;
    });
    //select.title(function (d){
    //    return 'STATE: ' + d.key;
    //});  */
        
    dc.renderAll();
    updateCounts();
}

function makePlayerColors() {
    playerColors = {};
    playerDim.top(Infinity).forEach(function (d) {
        playerColors[d.player] =  getColorForRegion(d.region);
    });
}

function getColorForRegion(region) {
    switch (region) {
        case "NA West": return "purple"; break;
        case "NA East": return "green"; break;
        case "Europe": return "blue"; break;
        case "Oceana": return "red"; break;
        case "Asia": return "brown"; break;
        case "Brazil": return "teal"; break;
    }  
}

function makePlayerStatsGroup() {
    playerStatsGroup =  

    playerDim.group().reduce(
        function (p, v) {
            p.payout = p.payout + v.payout;
            p.points = p.points + v.points;
            p.wins = p.wins + v.wins;
            p.elims = p.elims + v.elims;
            return p;
        },
        function (p, v) {
            p.payout = p.payout - v.payout;
            p.points = p.points - v.points;
            p.wins = p.wins - v.wins;
            p.elims = p.elims - v.elims;
            return p;
        },
        function (p) {
            return {   
                payout: 0
                , points: 0
                , wins: 0
                , elims: 0
            };
        }
    );
}