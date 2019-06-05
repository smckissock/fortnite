"use strict"


function regionChart(id) {

    const green ='#319236';
    const purple = '#9D4DBB';
    const blue = '#4C51F7';
    const red = '#DB4441';
    const teal = '#3E93BC';
    const lime = '#3CFF3E';
    const grey = '#B3B3B3';
    const brown = '#8B4513';
   
    const regions = [
        {x:50, y:80, color: green, name: "NA EAST", filter: "NA East", textOffset:33},
        {x:150, y:80, color: purple, name: "NA WEST", filter: "NA West", textOffset:35},
        {x:250, y:80, color: blue, name: "EUROPE", filter: "Europe", textOffset:30},
        {x:50, y:180, color: red, name: "OCEANA", filter: "Oceana", textOffset:32},
        {x:150, y:180, color: teal, name: "BRAZIL", filter: "Brazil", textOffset:26},
        {x:250, y:180, color: brown, name: "ASIA", filter: "Asia", textOffset:20}
    ];
    
    let regionCircles = [];
    const radius = 45; 
    
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

    const svg = div.append("svg")
        .attr("width", 300)
        .attr("height", (height * 5) + 30);
    
    svg.append("text")
        .attr("x", 10)
        .attr("y", 20)
        .text("Region")
        .attr("font-size", "1.6em")
        .attr("fill", "black"); 

    regions.forEach(function(region) {
        let circle = svg.append("circle")
            .attr("cx", region.x)
            .attr("cy", region.y)
            .attr("r", radius)
            .attr("fill", region.color)
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("data", region.filter)
            .on('mouseover', function (d) {
                // The are mousing over the selected item - don't shrink the border
                if (d3.select(this).attr("data") === filters.region)
                    return;

                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 5)
            })
            .on('mouseout', function (d) {
                let dom = d3.select(this);
                if (dom.attr("data") != filters.region)
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0); 
            })
            .on('click', function (d) {
                clickCircle(d3.select(this));
            });
            regionCircles.push(circle);    
                    
            svg.append("text")
                .attr("x", region.x - region.textOffset)
                .attr("y", region.y + 6)
                .text(region.name)
                .attr("font-size", "1.4em")
                .attr("fill", "black")
                .attr("pointer-events", "none");
    });


    const clickCircle = function(d3Circle) {
        const newFilter = d3Circle.attr("data");

        // 5 things need to happen:

        // 1) Update filters.region
        // 2) Set/unset crossfilter filter
        // 3) Draw correct outlines
        // 4) DC Redraw
        // 5) Update counts

       // 1 None were selected, this is the first selection
       if (filters.region === "") {
            filters.region = newFilter;
            _chart.filter(filters.region);
            d3Circle
                .transition()
                .duration(100)
                .attr("stroke-width", 10);

            _chart.redrawGroup();   
            updateCounts();
           return;
        }

        // 2 One is selected, so unselect it and select this
        if (filters.region != newFilter) {
            const oldFilter = filters.region;

            // Uncircle old one
            regionCircles.forEach(function(circle) {
                let dom = d3.select(circle._groups[0][0]);
                if (dom.attr("data") == oldFilter) {
                    // This will toggle it off
                    _chart.filter(oldFilter);
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0)
                }
            });

            filters.region = newFilter;
            _chart.filter(filters.region);
            d3Circle
                .transition()
                .duration(100)
                .attr("stroke-width", 10);

            _chart.redrawGroup();   
            updateCounts();
            
            showPlayerOnWeekChart("");
            return;
        }   
        
        // 3 This was selected, so unselect it - all will be selected
        filters.region = "";
        _chart.filter(null);
        d3Circle
            .transition()
            .duration(100)
            .attr("stroke-width", 0);
        
        _chart.redrawGroup();   
        updateCounts();
    }


    return _chart;
}