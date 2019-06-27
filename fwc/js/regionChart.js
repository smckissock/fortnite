import {colors} from "./shared.js";

import {cornerRadius, filters} from "./main.js";
import {clearPlayer} from "./playerChart.js";


export function regionChart(id) {

/*     const green ='#56af5a';
    const purple = '#ad76c1';
    const blue = '#4C51F7';
    const red = '#e25856';
    const teal = '#3E93BC';
    const lime = '#3CFF3E';
    const grey = '#B3B3B3';
    const brown = '#987654'; */
   
    const regions = [
        {x:53, y:80, color: colors.green, name: "NA EAST", filter: "NA East", textOffset:33},
        {x:153, y:80, color: colors.purple, name: "NA WEST", filter: "NA West", textOffset:35},
        {x:253, y:80, color: colors.blue, name: "EUROPE", filter: "Europe", textOffset:30},
        {x:53, y:180, color: colors.red, name: "OCEANIA", filter: "Oceania", textOffset:34},
        {x:153, y:180, color: colors.teal, name: "BRAZIL", filter: "Brazil", textOffset:26},
        {x:253, y:180, color: colors.brown, name: "ASIA", filter: "Asia", textOffset:19}
    ];
    
    let regionCircles = [];
    const radius = 45;
    const strokeWidthThick = 8;
    const strokeWidthThin = 4; 
    
    const width = 135;
    const height = 80;
    
    const div = d3.select(id);

    // The selection circle what moves around when the current week changes
    //let cursor;
    //let cursorVisible = false;
    
    // Include this, and add a dimension and group
    // Later call these on a click to filter: 
    //    _chart.filter(filter);
    //    _chart.redrawGroup();
    const _chart = dc.baseMixin({});
    // This only filters. It doesn't display a group metric, and it does not respond
    // to changes in the group metric based on other filters.

    // Also - make sure to return _chart; at the end of the function, or chaining won't work! 

    const svg = div.append("svg")
        .attr("width", 310)
        .attr("height", (height * 5) + 30);
    
    svg.append("text")
        .attr("x", 14)
        .attr("y", 20)
        .text("Regions")
        .attr("font-size", "1.8em")
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
                    .attr("stroke-width", strokeWidthThin)
            })
            .on('mouseout', function (d) {
                let dom = d3.select(this);
                //if (filters.regions.indexOf(dom.attr("data")) != -1)
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", (filters.regions.indexOf(dom.attr("data")) == -1) ? 0 : strokeWidthThick); 
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

    // Make this after the region circles so that always appears "on top"
    /* cursor = svg.append("circle")
            .attr("cx", 50)
            .attr("cy", 80)
            .attr("r", radius)
            .attr("fill", "none")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("pointer-events", "none");
    
    function moveCursor(hide) {
        if (hide) {
            cursorVisible = false;
            cursor
                .transition()
                .duration(80)
                .attr("stroke-width", strokeWidthThick + 2)
                .transition()
                .duration(350)
                .attr("stroke-width", 0);
            return;    
        }

        const newRegion = regions.find(d => d.filter === filters.region);
        if (!cursorVisible) {
            cursorVisible = true;
            cursor
                .attr("cx", newRegion.x)
                .attr("cy", newRegion.y) 
            cursor
                .transition()
                .duration(100)
                .attr("stroke-width", strokeWidthThick);
        } else {
            cursor
                .transition()
                .ease(d3.easeBack) 
                .duration(300)
                .attr("cx", newRegion.x)
                .attr("cy", newRegion.y) 
        }
    }
 */

    const clickCircle = function(d3Circle) {
        const newFilter = d3Circle.attr("data");
        
        // 5 things need to happen:

        // 1) Update filters.regions[]
        // 2) Set/unset crossfilter filter
        // 3) Draw correct outlines
        // 4) DC Redraw
        // 5) Update counts

        // Regardless of what happens below, selected player needs to be cleared 
        clearPlayer(null);

        // 1 None were selected, this is the first selection
        //if (filters.region === "") {
        if (filters.regions.length === 0) {    
            filters.regions.push( newFilter);
            _chart.filter(filters.regions[0]);
            d3Circle
                .transition()
                .duration(100)
                .attr("stroke-width", strokeWidthThick);

            _chart.redrawGroup();   

            //moveCursor(false);
            return;
        }

        // 2 One is selected, so unselect it and select this
        // One is selected other than what was clicked, so add it
        //if (filters.region != newFilter) {
        if (filters.regions.indexOf(newFilter) == -1) {
            const oldFilter = filters.region;

            // Uncircle old one
            regionCircles.forEach(function(circle) {
                let dom = d3.select(circle._groups[0][0]);
                if (dom.attr("data")  == oldFilter) {
                    // This will toggle it off
                    _chart.filter(oldFilter);
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", strokeWidthThick)
                }
            });

            filters.regions.push(newFilter);
            _chart.filter([[newFilter]]);
            d3Circle
                .transition()
                .duration(100)
                .attr("stroke-width", strokeWidthThick);

            _chart.redrawGroup();   

            //moveCursor(false);
            return;
        }   
        
        // 3 This was already selected, so toggle it off 
        filters.regions = filters.regions.filter(d => d !== newFilter)
        _chart.filter([[newFilter]]);
        d3Circle
            .transition()
            .duration(100)
            .attr("stroke-width", 0);
        
        _chart.redrawGroup();   
        //moveCursor(true);
    }

    return _chart;
}