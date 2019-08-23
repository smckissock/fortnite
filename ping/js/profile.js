//import { playerTableWidth } from "./playerChart.js";
import { cornerRadius, filters, facts, updateCounts, statsForPlayer, playerInfos } from "./main.js";

import { text } from "./shared.js";

export function profile(player) {

    let svg;
    let rect;

    const svgWidth = 1000;
    const svgHeight = 700;

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
            .attr("height", svgHeight + 7)
            .attr("transform", "translate(-150,-1290)")
            .attr("fill", "black")

        rect = svg.append("rect")
            .attr("x", 3)
            .attr("y", 84)
            .attr("width", svgWidth)
            .attr("height", svgHeight)
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
        let team = "";
        let nationality = "";
        let age = "";
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
        const left = 24;
        svg.append("text")
            .classed("player-summary", true)
            .attr("x", left)
            .attr("y", 122)
            .text(player)
            .attr("fill", "black")
            .attr("font-size", 0)
            .transition()
            .duration(140)
            .attr("y", 135)
            .attr("font-size", (player.length < 16) ? "2.4em" : "1.8em")

        // Player team, nationality & age, if any 
        text(playerInfoLabel, svg, "player-info", left, 165);
    }

    function makeStats() {

        const colWidth = 100;
        const cols = [
            {name: "Payout", field: "payout"},
            {name: "Points", field: "points"},
            {name: "Wins", field: "wins"},
            {name: "Elim Points", field: "elims"},
            {name: "Elim %", field: "elims"},
            {name: "Qual Points", field: "placementPoints"},
            {name: "Qual %", field: "placementPoints"}
        ];

        function writeNumber(x, y, text) {
            svg.append("text")
                .classed("player-summary", true)
                .classed("player-stat", true)
                .attr("x", x)
                .attr("y", y)
                .text(text)
        }
    
        function writeRank(x, y, text) {
            svg.append("text")
                .classed("player-summary", true)
                .classed("player-rank", true)
                //.attr("x", x + 40 - (text.length * 9)) // Don't attempt to right-justify
                .attr("x", x)
                .attr("y", y)
                .text("#" + text)
        }
    
        function writeText(x, y, text) {
            svg.append("text")
                .classed("player-summary", true)
                .classed("player-stat-label", true)
                .attr("x", x)
                .attr("y", y)
                .attr("font-family", "Helvetica, Arial, sans-serif")
                .text(text)
        }
        

        function columnHeaders() {            
            const rowHeaderWidth = 100;
            svg.selectAll(".player-stat-col-header").data(cols).enter().append("text")
                .attr("x", (d, i) => rowHeaderWidth + i * colWidth)
                .attr("y", 200)
                .attr("pointer-events", "none")
                .classed("player-stat-col-header", true)
                .text(d => d.name)
                .each(d => console.log(d))
        }
        
        function rows(recs) {
            const rowHeaderWidth = 100;
            const rowHeight = 30;

            svg.selectAll("g").data(recs).enter().append("g")
                .each(function (row, rowNum) {
                    text(row.week, svg, "player-stat-row", 10, 240 + rowHeight * rowNum); 
                    cols.forEach((col, colNum) => text(row[col.field], svg, "player-stat-row", 100 + colNum * colWidth, 240 + rowHeight * rowNum))
                    console.log(row.week);    
                });
        }

        const x0 = 10;
        const x1 = 75;
        const x2 = 150;
        const x3 = 225;
        const yStep = 38;
        const yRank = 16;

        //writeText(x1 + 5, 189, "Solo");
        //writeText(x2 + 5, 189, "Duo");
        //writeText(x3, 189, "Total");

        const recs = facts.all().filter(x => x.player === player);
        const matches = recs.filter(x => "Week 1" === x.week);
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