"use strict"
 
function weekChart(id) {

    const weeks = [
        {num: 1, type:"Solo", done: true},
        {num: 2, type:"Duo", done: true},
        {num: 3, type:"Solo", done: true},
        {num: 4, type:"Duo", done: true},
        {num: 5, type:"Solo", done: true},
        {num: 6, type:"Duo", done: true},
        {num: 7, type:"Solo", done: true},
        {num: 8, type:"Duo", done: true},
        {num: 9, type:"Solo", done: false},
        {num: 10, type:"Duo", done: false},
    ];
    
    let weekRects = [];

    const soloX = 10;
    const duoX = 155; 

    const width = 135;
    const height = 80;
    
    const div = d3.select(id);
    
    // Include this, and add a dimension and group
    // Later call these on a click to filter: 
    //    _chart.filter(filter);
    //    _chart.redrawGroup();
    const _chart = dc.baseMixin({});
    // This only filters. It doesn't display a group metric, and it does not respond
    // to changes in the group metric based on other filters.

    // Also - make sure to return _chart; at the end of the function, or chaining won't work! 

    const bigLabel = {x: 25, y: 45, size: "2em" }
    const smallLabel = {x: 40, y: 30, size: "1.2em" }

    const svg = div.append("svg")
        .attr("width", 300)
        .attr("height", (height * 5) + 30);
    
    svg.append("text")
        .attr("x", 60)
        .attr("y", 25)
        .text("Solo")
        .attr("font-size", "1.6em")
        .attr("fill", "black"); 

    svg.append("text")
        .attr("x", duoX + 45)
        .attr("y", 25)
        .text("Duo")
        .attr("font-size", "1.8em")
        .attr("fill", "black");

    const top = 40;
    let count = 0;      
    weeks.forEach(function(week) {
        const x = week.type === "Solo" ? soloX : duoX;
        const y = Math.round((count-1)/2) * height + top;

        const yellowGreen = "#9ACD32"
        const red = "Red";
        const grey = '#B3B3B3';

        let color = (week.type === "Duo") ? yellowGreen : red;
        if (!week.done)
            color = grey;

        const rect = svg.append("rect")
            .attr("x", x)
            .attr("y", y)
            .attr("width", width)
            .attr("height", height - 10)
            .attr("fill", color)
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("data", week.num)
            //.classed("week-chart", true)
            .on('mouseover', function (d) {
                const num = d3.select(this).attr("data");

                // The are mousing over the selected item - don't shrink the border
                if ("Week " + num === filters.week)
                    return;

                // Don't do anything for weeks that aren't done     
                if (!weeks.filter(x => x.num == num)[0].done)
                    return;    
                
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 5)
            })
            .on('mouseout', function (d) {
                let dom = d3.select(this);
                if ("Week " + dom.attr("data") != filters.week)
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0); 
            })
            .on('click', function (d) {
                clickRect(d3.select(this));
            });

        weekRects.push(rect);

        svg.append("text")
            .attr("x", x + bigLabel.x)
            .attr("y", y + bigLabel.y)
            .text("Week " + (count + 1))
            .attr("font-size", bigLabel.size)
            .attr("fill", "black")    
            .attr("pointer-events", "none");
            
        count++;    
    });

    const clickRect = function(d3Rect) {
        const num = d3Rect.attr("data");

        // Don't do anything for weeks that aren't done     
        if (!weeks.filter(x => x.num == num)[0].done)
            return;   

        const newFilter = "Week " + num;

        // 5 things need to happen:

        // 1) Update filters.region
        // 2) Set/unset crossfilter filter
        // 3) Draw correct outlines
        // 4) DC Redraw
        // 5) Update counts

       // 1 None were selected, this is the first selection
       if (filters.week === "") {
            filters.week = newFilter;

            _chart.filter(filters.week);
            d3Rect
                .transition()
                .duration(100)
                .attr("stroke-width", 9);

            _chart.redrawGroup();   
            updateCounts();
           return;
        }

        // 2 One is selected, so unselect it and select this
        if (filters.week != newFilter) {
            const oldFilter = filters.week;

            // Un-border old one
            weekRects.forEach(function(week) {
                let dom = d3.select(week._groups[0][0]);
                if ("Week " + dom.attr("data") == oldFilter) {
                    // This will toggle it off
                    _chart.filter(oldFilter);
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0)
                }
            });

            filters.week = newFilter;
            _chart.filter(filters.week);
            d3Rect
                .transition()
                .duration(100)
                .attr("stroke-width", 9);

            _chart.redrawGroup();   
            updateCounts();
            return;
        }   

        // 3 This was selected, so unselect it - all will be selected
        filters.week = "";
        _chart.filter(null);
        d3Rect
            .transition()
            .duration(100)
            .attr("stroke-width", 0);
        
        _chart.redrawGroup();   
        updateCounts();
    }

    return _chart;
}