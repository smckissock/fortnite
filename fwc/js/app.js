'use strict';

let playerDim;
let playerStatsGroup;

let playerTable;

let playerColors;

let theWeekChart; 

let facts;

let selectedPlayerNode;

// Function that weekChart sets and personChart calls!! 
let showPlayerOnWeekChart;

let filters = {
    week: "",
    region: "",
    search: "",
    player: "",
    playerCount: 0
}


d3.json('fwc/data/data.json').then(function (data)  {
    title();
    
    data.forEach(function (d) {
        d.rank = +d.rank;
        d.payout = +d.payout;
        d.points = d.points;
    });
    facts = crossfilter(data);
    draw(facts);

    d3.select("#search-input").on('keyup', function (event) {
        // Regardless of what happens below, selected player needs to be cleared 
        filters.player = "";
        showPlayerOnWeekChart();

        const searchTerm = document.getElementById("search-input").value;
        
        filters.search = searchTerm; 
        playerDim.filter(function (d) { 
            return d.toLowerCase().indexOf(searchTerm.toLowerCase()) !== -1;
        });
        
        updateCounts();
        dc.redrawAll();
    });
});


function title() {
    const div = d3.select(".title");
    const svg = div.append("svg")
        .attr("width", "1000px")
        .attr("height", "70px");
    
    svg.append("text")
        .attr("x", 0)
        .attr("y", 65)
        .text("FORTNITE  World Cup Stats")
        .attr("font-size", "1.1em")
        .attr("fill", "black"); 
    
    helpButton(svg);
}

function helpButton(svg) {
    
    svg.append("circle")
        .attr("cx", 730)
        .attr("cy", 46)
        .attr("r", 22)
        .attr("fill", "green")
        .attr("stroke", "black")
        .attr("stroke-width", 0)
        .on('mouseover', function (d) {
            d3.select(this)
                .transition()
                .duration(100)
                .attr("stroke-width", 4)
        })
        .on('mouseout', function (d) {
            d3.select(this)
                .transition()
                .duration(100)
                .attr("stroke-width", 0); 
        })
        .on('click', function (d) {
            window.open('help.html', '_blank');    
        });
        
    svg.append("text")
        .attr("x", 722)
        .attr("y", 61)
        .text("?")
        .attr("font-size", ".7em")
        .attr("fill", "black")
        .attr("pointer-events", "none");     
}


function updateCounts() {
    makePlayerStatsGroup(playerDim);

    let filtersText = "";
    if (filters.player != "") {
        filtersText = filters.player;
    } else {
        // Add commas to number
        const num = d3.format(",d");
        filtersText = 
            filters.week + " " + filters.region + " " + filters.search + " " + num(filters.playerCount) + " players";  
    }

    d3.select("#count-box")
        .text(filtersText);
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
            function (d) { return d.value.soloQual },
            function (d) { return d.value.duoQual },
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
        case "Oceana": return "red2"; break;
        case "Asia": return "brown"; break;
        case "Brazil": return "teal"; break;
    }  
}

function makePlayerStatsGroup() {
    playerStatsGroup =  

    playerDim.group().reduce(
        function (p, v) {
            p.soloQual = p.soloQual + v.soloQual;
            p.duoQual = p.duoQual + v.duoQual;

            p.payout = p.payout + v.payout;
            p.points = p.points + v.points;
            p.wins = p.wins + v.wins;
            p.elims = p.elims + v.elims;
            return p;
        },
        function (p, v) {
            p.soloQual = p.soloQual - v.soloQual;
            p.duoQual = p.duoQual - v.duoQual;

            p.payout = p.payout - v.payout;
            p.points = p.points - v.points;
            p.wins = p.wins - v.wins;
            p.elims = p.elims - v.elims;
            return p;
        },
        function (p) {
            return {   
                soloQual:0
                ,duoQual: 0 
                ,payout: 0
                , points: 0
                , wins: 0
                , elims: 0
            };
        }
    );
}