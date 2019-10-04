import { colors } from "./shared.js";

import { filters } from "./main.js";
import { clearPlayer } from "./playerChart.js";
import { clearTeam } from "./teamChart.js";


export function regionChart(id) {

    const left = 5;
    const rectWidth = 160;
    const rectHeight = 60
    
    const regions = [
        { x: left, y: 0, color: colors.green, name: "NA EAST", filter: "NA East", textOffset: 32 },
        { x: left, y: rectHeight * 1, color: colors.orange, name: "NA WEST", filter: "NA West", textOffset: 31 },
        { x: left, y: rectHeight * 2, color: colors.blue, name: "EUROPE", filter: "Europe", textOffset: 29 },
        { x: left, y: rectHeight * 3, color: colors.pink, name: "OCEANIA", filter: "Oceania", textOffset: 29 },
        { x: left, y: rectHeight * 4, color: colors.teal, name: "BRAZIL", filter: "Brazil", textOffset: 41 },
        { x: left, y: rectHeight * 5, color: colors.yellow, name: "ASIA", filter: "Asia", textOffset: 55 },
        { x: left, y: rectHeight * 6, color: colors.grey, name: "MIDDLE EAST", filter: "Middle East", textOffset: 9 }
    ];

    let regionRects = [];
    
    
    const strokeWidthThick = 8;
    const strokeWidthThin = 3;
    const strokeDuration = 100;

    //const height = 80;

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
        .classed("region-svg", true)
        .attr("width", 180)
        .attr("height", (rectHeight * 7) + 30);

    svg.selectAll("rect").data(regions).enter().append("rect")
        .attr("x", d => d.x)
        .attr("y", d => d.y + 10)
        .attr("width", rectWidth)
        .attr("height", rectHeight - 10)
        .attr("fill", d => d.color)
    
        .attr("stroke", "black")
        .attr("stroke-width", 0)
        .attr("data", d => d.filter)
        .on('mouseover', function (d) {
            // The are mousing over the selected item - don't shrink the border
            if (d3.select(this).attr("data") === filters.region)
                return;
    
            d3.select(this)
                .transition()
                .duration(strokeDuration)
                .attr("stroke-width", strokeWidthThin)
        })
        .on('mouseout', function (d) {
            let dom = d3.select(this);
            dom
                .transition()
                .duration(strokeDuration)
                .attr("stroke-width", (filters.regions.indexOf(dom.attr("data")) == -1) ? 0 : strokeWidthThick);
        })
        .on('click', function (d) {
            clickRect(d3.select(this));
        })
        .each(d => regionRects.push(d3.select(this)));
    
        svg.selectAll("text").data(regions).enter().append("text")
            .attr("x", d => d.x + d.textOffset)
            .attr("y", d => d.y + 42)
            .text(d => d.name)
            .attr("font-size", "1.5em")
            .attr("font-weight", "400")
            .attr("fill", "black")
            .attr("pointer-events", "none"); 

    const clickRect = function (rect) {
        const newFilter = rect.attr("data");

        // 5 things need to happen:

        // 1) Update filters.regions[]
        // 2) Set/unset crossfilter filter
        // 3) Draw correct outlines
        // 4) DC Redraw
        // 5) Update counts

        // Regardless of what happens below, selected player needs to be cleared 
        clearPlayer(null);
        clearTeam();

        // 1 None were selected, this is the first selection
        if (filters.regions.length === 0) {
            filters.regions.push(newFilter);
            //filters.regions.push("All");

            _chart.filter(filters.regions[0]);
            //_chart.filter([["All"]]);
            rect
                .transition()
                .duration(strokeDuration)
                .attr("stroke-width", strokeWidthThick);

            _chart.redrawGroup();
            return;
        }
        
        // An unselected rect was clicked, so add it.
        if (filters.regions.indexOf(newFilter) == -1) {
            filters.regions.push(newFilter);
            _chart.filter([[newFilter]]);
            
            rect
                .transition()
                .duration(strokeDuration)
                .attr("stroke-width", strokeWidthThick);

            _chart.redrawGroup();
            return;
        }

        // 3 This was already selected, so toggle it off 
        filters.regions = filters.regions.filter(d => d !== newFilter)
        _chart.filter([[newFilter]]);
        rect
            .transition()
            .duration(strokeDuration)
            .attr("stroke-width", 0);

        _chart.redrawGroup();
    }

    return _chart;
}