//import { playerTableWidth } from "./playerChart.js";
import { cornerRadius, filters, facts, updateCounts, statsForPlayer, playerInfos } from "./main.js";

import { text } from "./shared.js";

export function profile(player) {

    let svg;
    let rect;

    function enableSvgs (enabled) {
        // Disable everything
        const val = enabled ? "auto" : "none"
        d3.selectAll("svg")
        .each(function() {
            d3.select(this)
                .attr("pointer-events", val); 
            console.log(val)
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
            //.attr("width", playerTableWidth + 4)
            .attr("width", 800)
            .attr("height", 1000)
            .attr("transform", "translate(0,-1090)")
            .attr("fill", "black")

        rect = svg.append("rect")
            .attr("x", 3)
            .attr("y", 84)
            .attr("width", 700)
            .attr("height", 500)
            .attr("opacity", 1.0)
            .attr("fill-opacity", 1.0)
            .attr("fill", "#F0F8FF")
            .attr("stroke", "black")
            .attr("stroke-width", 9)
            .attr("rx", 6)
            .attr("ry", 6)
    }

    function makeHelpButton(svg, screenWidth) {
        text("Fortnite", svg, "little-fortnite", screenWidth - 230, 126);
        text("ping", svg, "little-ping", screenWidth - 120, 126);

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

    
    function showPlayerHeader(stats, region) {
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

    function writeNumber(x, y, text) {
        regionSvg.append("text")
            .classed("player-summary", true)
            .classed("player-stat", true)
            .attr("x", x)
            .attr("y", y)
            .text(text)
    }

    function writeRank(x, y, text) {
        regionSvg.append("text")
            .classed("player-summary", true)
            .classed("player-rank", true)
            //.attr("x", x + 40 - (text.length * 9)) // Don't attempt to right-justify
            .attr("x", x)
            .attr("y", y)
            .text("#" + text)
    }

    function writeText(x, y, text) {
        regionSvg.append("text")
            .classed("player-summary", true)
            .classed("player-stat-label", true)
            .attr("x", x)
            .attr("y", y)
            .attr("font-family", "Helvetica, Arial, sans-serif")
            .text(text)
    }

    const num = d3.format(",d");
            

    const recs = facts.all().filter(x => x.player === player);
    if (recs.length == 0)
        return;


    enableSvgs(false);
    makeSvg();
    makeHelpButton(svg, 694) 
        
    const region = recs[0].region;
    const stats = statsForPlayer(region, player);
    showPlayerHeader(stats, region);
    

    //text(svg, "event-name", 20, 120, player)
}