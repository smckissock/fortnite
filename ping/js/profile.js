//import { playerTableWidth } from "./playerChart.js";
import { cornerRadius, filters, facts, updateCounts, statsForPlayer, playerInfos } from "./main.js";

import { text } from "./shared.js";

export function profile(player) {

    let svg;
    let rect;

    const svgWidth = 1000;
    const svgHeight = 700;

    const leftMargin = 40;

    function enableSvgs (enabled) {
        const val = enabled ? "auto" : "none"
        d3.selectAll("svg")
        .each(function() {
            d3.select(this)
                .attr("pointer-events", val);
        })
    }

    function hide() {
        enableSvgs(true);
        rect.transition()
            .duration(100)
            .attr("fill-opacity", .0)
            .attr("opacity", .0)
            .on("end", () => svg.remove());
    }

    function makeSvg () {
        const div = d3.select("#chart-player");
        svg = div.append("svg")            
            .attr("width", svgWidth + 6)
            .attr("height", svgHeight + 6)
            .attr("transform", "translate(-150,-1290)")
            .attr("fill", "black")

        const top = 84;    
        rect = svg.append("rect")
            .attr("x", 3)
            .attr("y", top)
            .attr("width", svgWidth)
            .attr("height", svgHeight - top)
            .attr("opacity", 1.0)
            .attr("fill-opacity", 1.0)
            .attr("fill", "#F0F8FF")
            .attr("stroke", "black")
            .attr("stroke-width", 9)
            .attr("rx", 6)
            .attr("ry", 6)
    }

    function makeHelpButton(svg, screenWidth) {
        //text("Fortnite", svg, "little-fortnite", screenWidth - 280, 126);
        text("fortniteping.com", svg, "little-ping", screenWidth - 285, 127);

        svg.append("circle")
            .attr("cx", screenWidth - 30)
            .attr("cy", 120)
            .attr("r", 22)
            .attr("fill", "lightblue")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .on('mouseover', function (d) {
                d3.select(this)
                    .transition()
                    .duration(50)
                    .attr("stroke-width", 6)
            })
            .on('mouseout', function (d) {
                d3.select(this)
                    .transition()
                    .duration(50)
                    .attr("stroke-width", 0);
            })
            .on('click', function (d) {
                hide();
            });
    
        svg.append("text")
            .attr("x", screenWidth - 38)
            .attr("y", 128)
            .text("X")
            .attr("font-size", "1.7em")
            .attr("fill", "black")
            .attr("pointer-events", "none");
    }

    
    function makePlayerHeader(stats, region) {
        let playerInfoLabel = "";
        const players = playerInfos.filter(d => d.name === player);
        if (players.length > 0) {
            let info = [];
            info.push(players[0].age == "" ? "" : "Age " + players[0].age);
            info.push(players[0].team);
            info.push(players[0].nationality);

            info = info.filter(d => d != "");
            playerInfoLabel = info.join(" | ");
        }

        if (player === "Posick")
            playerInfoLabel = "19 | Free Agent | Arlington, Virginia"

        // Player Name
        svg.append("text")
            .classed("player-summary", true)
            .attr("x", leftMargin)
            .attr("y", 122)
            .text(player)
            .attr("fill", "black")
            .attr("font-size", 0)
            .transition()
            .duration(140)
            .attr("y", 135)
            .attr("font-size", (player.length < 16) ? "2.4em" : "1.8em")

        // Player team, nationality & age, if any 
        text(playerInfoLabel, svg, "player-info", leftMargin, 165);
    }

    function makeStats() {

        const colWidth = 100;
        const rowHeaderWidth = 340;
        const topRowY = 240;

        const noFormat = function (d) { return d; }
        const commaFormat = d3.format(",");
        const pctFormat = d3.format(",.1%");
        const pctAxisFormat = d3.format(",.0%");
        const moneyFormat = function (d) { return "$" + d3.format(",")(d); };
        const moneyKFormat = d3.format(".2s");
    

        const cols = [
            {name: "Payout", field: "payout", format: commaFormat},
            {name: "Points", field: "points", format: noFormat},
            {name: "Wins", field: "wins", format: noFormat},
            {name: "Elim Pts", field: "elims", format: noFormat},
            {name: "Elim %", field: "elimPct", format: pctFormat},
            {name: "Qual Pts", field: "placementPoints", format: noFormat},
            {name: "Qual %", field: "placementPct", format: pctFormat}
        ];

        function columnHeaders() {            
            const rowHeaderWidth = 100;
            svg.selectAll(".player-stat-col-header").data(cols).enter().append("text")
                .attr("x", (d, i) => rowHeaderWidth + ((i + 2) * colWidth) - 10)
                .attr("y", 200)
                .attr("pointer-events", "none")
                .classed("player-stat-col-header", true)
                .text(d => d.name)
                .each(d => console.log(d))
        }
        
        function rows(recs) {
            const rowHeight = 30;
            svg.selectAll("g").data(recs).enter().append("g")
                .each((row, rowNum) => {
                    // Row header
                    text(row.week, svg, "player-stat-row", leftMargin, topRowY + (rowHeight * rowNum)); 
                    // Numeric columns 
                    cols.forEach(function (col, colNum) { 
                        const toShow = col.format(row[col.field]).toString()
                        text(
                            toShow, 
                            svg, 
                            "player-stat-row", 
                            rowHeaderWidth + (colNum * colWidth) - 
                                // Source Sans Pro has monospaced numbers, but commas are narrower than numbers
                                (toShow.length * 10) +                         
                                ((toShow.match(/,/g) || []).length) * 4, 
                            topRowY + (rowHeight * rowNum))
                    });
                });
        }

        const recs = facts.all().filter(x => x.player === player);
        recs.forEach(function(d) {
            d.elimPct =  d.elims / d.points;
            d.placementPct =  d.placementPoints / d.points;
        })

        //const matches = recs.filter(x => "Week 1" === x.week);
        columnHeaders();
        rows(recs);
    }

    const num = d3.format(",d");
            

    const recs = facts.all().filter(x => x.player === player);
    if (recs.length == 0)
        return;


    enableSvgs(false);
    makeSvg();
    makeHelpButton(svg, svgWidth) 
        
    const region = recs[0].region;
    const stats = statsForPlayer(region, player);
    makePlayerHeader(stats, region);
    makeStats();
}