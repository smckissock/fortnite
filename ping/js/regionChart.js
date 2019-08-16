// @language_out ecmascript5

import { colors } from "./shared.js";

import { filters } from "./main.js";
import { clearPlayer } from "./playerChart.js";
import { clearTeam } from "./teamChart.js";


export function regionChart(id) {

    const left = 5;
    //const height = 100;
    const rectWidth = 160;
    const rectHeight = 60
    
    const regions = [
        { x: left, y: 0, color: colors.green, name: "NA EAST", filter: "NA East", textOffset: 6 },
        { x: left, y: rectHeight * 1, color: colors.purple, name: "NA WEST", filter: "NA West", textOffset: 5 },
        { x: left, y: rectHeight * 2, color: colors.blue, name: "EUROPE", filter: "Europe", textOffset: 5 },
        { x: left, y: rectHeight * 3, color: colors.red, name: "OCEANIA", filter: "Oceania", textOffset: 2 },
        { x: left, y: rectHeight * 4, color: colors.teal, name: "BRAZIL", filter: "Brazil", textOffset: 14 },
        { x: left, y: rectHeight * 5, color: colors.brown, name: "ASIA", filter: "Asia", textOffset: 29 }
    ];

    let regionRects = [];
    
    
    const strokeWidthThick = 8;
    const strokeWidthThin = 4;

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
        .attr("height", rectHeight - 17)
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
            clickRect(d3.select(this));
        })
        .each(d => regionRects.push(d3.select(this)));
    
        svg.selectAll("text").data(regions).enter().append("text")
            .attr("x", d => d.x + d.textOffset + 20)
            .attr("y", d => d.y + 40)
            .text(d => d.name)
            .attr("font-size", "1.7em")
            .attr("font-weight", "800")
            .attr("fill", "black")
            .attr("pointer-events", "none"); 


    /* regions.forEach(function (region) {
        //let rect = svg.append("circle")
        let rect = svg.append("rect")
            //.attr("cx", region.x)
            //.attr("cy", region.y)
            //.attr("r", radius)
            //.attr("fill", region.color)

            .attr("x", region.x)
            .attr("y", region.y)
            .attr("width", rectWidth)
            .attr("height", rectHeight)
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

        regionRects.push(rect);

        svg.append("text")
            .attr("x", region.x - region.textOffset)
            .attr("y", region.y + 6)
            .text(region.name)
            .attr("font-size", "1.4em")
            .attr("fill", "black")
            .attr("pointer-events", "none");
    }); */

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
            _chart.filter(filters.regions[0]);
            rect
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
            regionRects.forEach(function (circle) {
                let dom = d3.select(circle._groups[0][0]);
                if (dom.attr("data") == oldFilter) {
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
            rect
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
        rect
            .transition()
            .duration(100)
            .attr("stroke-width", 0);

        _chart.redrawGroup();
        //moveCursor(true);
    }

    return _chart;
}