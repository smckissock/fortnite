'use strict';

let playerDim;

let playerStats;

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

        playerDim.filter(function (d) { 
            return d.toLowerCase().indexOf (searchTerm) !== -1;} );
            //$(".resetall").attr("disabled",false);
            //throttle();
            dc.redrawAll();
            // RefreshTable
    });
});


function draw(facts) {
    let playerChart = new TableChart(facts, "player", 300, 25);
    playerDim = playerChart.dim;

    new RowChart(facts, "region", 300, 10);
    new RowChart(facts, "week", 300, 10);

    //var runDimension = ndx.dimension(function(d) {function(d) {return [fmt(+d.Expt),fmt(+d.Run)];});
    //var runDimension = facts.dimension(function(d) {return [+d.payout, +d.points, +d.grandRoyale, +d.elimPoints];});
    //var chart = dc.dataTable("#dc-chart-table");
    //var fmt = d3.format('02d');
    //chart
    //    .width(300)
    //    .height(480)
    //    .dimension(runDimension)
    //    .size(Infinity)
    //    .showSections(false)
    //    .columns(['player', 'payout', 'points', 'grandRoyale', 'elimPoints'])
        //.sortBy(function (d) { return [fmt(+d.payout)]; })
        
    //    .sortBy(dc.pluck('payout'))
    //    .order(d3.descending)
        //.on('preRender', update_offset)
        //.on('preRedraw', update_offset)
        //.on('pretransition', display);


    playerStats = facts.dimension(dc.pluck("player"));
    var playerStatsGroup = playerStats.group().reduce(
        function (p, v) {
            p.payout = p.payout + v.payout;
            p.points = p.points + v.points;
            return p;
        },
        function (p, v) {
            p.payout = p.payout - v.payout;
            p.points = p.points - v.points;
            return p;
        },
        function () {
            return {   
                payout: 0
                , points: 0
                    //, grandRoyale: 0
                    //,elimPoints: 0
            };
        }
    );

    dc.dataGrid("#dc-chart-table")
    .dimension(playerStats)
    .section(function (d) {
        return "HI";
    })
    .size(10000)
    .html (function(d) { return chartHtml(d);})
    .sortBy(function (d) {
        return d.payout;
    })
    .order(d3.descending)


    dc.renderAll();
}

function chartHtml (d) {
    return "PLPP";
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

var TableChart = function (facts, attribute, width, maxItems) {
    this.dim = facts.dimension(dc.pluck(attribute));
    //dc.rowChart("#dc-chart-" + attribute)
    dc.tableChart("#dc-chart-" + attribute)
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