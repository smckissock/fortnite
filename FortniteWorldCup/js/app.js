'use strict';

let playerDim;
let playerStatsGroup;

//let playerStats;

let playerTable;

d3.json('data/data.json').then(function (data)  {
    data.forEach(function (d) {
        d.rank = +d.rank;
        d.payout = +d.payout;
        d.points = d.points;
    });
    var facts = crossfilter(data);
    draw(facts);

    d3.select("#search-input").on('keyup', function (event) {
        const searchTerm = document.getElementById("search-input").value;
        console.log(searchTerm);
        console.group(playerDim.top(10000).length);
        console.log(playerStatsGroup.all().length);

        playerDim.filter(function (d) { 
            return d.toLowerCase().indexOf(searchTerm) !== -1;
        });

        dc.redrawAll();
    });
});


function draw(facts) {
    new RowChart(facts, "region", 300, 10);
    new RowChart(facts, "week", 300, 10);

    playerDim = facts.dimension(dc.pluck("player"));
    playerStatsGroup = playerDim.group().reduce(
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
        function () {
            return {   
                payout: 0
                , points: 0
                , wins: 0
                , elims: 0
                    //, grandRoyale: 0
                    //,elimPoints: 0
            };
        }
    );

    playerTable = dc.newDataTable("#dc-chart-player");
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
        .order(d3.descending)
        
    dc.renderAll();
}


var RowChart = function (facts, attribute, width, maxItems) {
    this.dim = facts.dimension(dc.pluck(attribute));
    //dc.rowChart("#dc-chart-" + attribute)
    dc.rowChart("#dc-chart-" + attribute)
        .dimension(this.dim)
        .group(this.dim.group().reduceSum(dc.pluck("payout")))
        .data(function (d) { return d.top(maxItems); })
        .width(width)
        .height(maxItems * 22)
        .margins({ top: 0, right: 10, bottom: 20, left: 20 })
        .elasticX(true)
        //.ordinalColors(['#9ecae1']) // light blue
        //.ordinalColors(['#00008b']) // dark blue
        .ordinalColors(['#04c7ff']) // dark blue
        .labelOffsetX(5)
        .xAxis().ticks(4).tickFormat(d3.format(".2s"));
}