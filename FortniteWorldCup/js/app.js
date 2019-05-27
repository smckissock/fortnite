'use strict';

d3.json('data/data.json').then(function (data)  {
    data.forEach(function (d) {
        d.rank = +d.rank;
        d.payout = +d.payout;
        d.points = d.points;
    });
    var facts = crossfilter(data);
    draw(facts);
});

function draw(facts) {
    new RowChart(facts, "player", 300, 25);
    new RowChart(facts, "region", 300, 10);
    //new RowChart(facts, "soloOrDuo", 300, 10);
    new RowChart(facts, "week", 300, 10);

    // draw all dc charts. w/o this nothing happens!  
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
        .ordinalColors(['#9ecae1']) // light blue
        //.ordinalColors(['#00008b']) // dark blue
        .labelOffsetX(5)
        .xAxis().ticks(4).tickFormat(d3.format(".2s"));
}