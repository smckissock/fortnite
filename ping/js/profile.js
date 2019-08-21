
//import { playerTableWidth } from "./playerChart.js";
import { text } from "./shared.js";

export function profile(player) {

    const div = d3.select("#chart-player");
    const svg = div.append("svg")
        //.attr("width", playerTableWidth + 4)
        .attr("width", 800)
        .attr("height", 1000)
        .attr("transform", "translate(0,-1090)")

    svg.append("rect")
        .attr("x", 3)
        .attr("y", 84)
        .attr("width", 700)
        .attr("height", 500)
        .attr("fill", "#F0F8FF")
        .attr("stroke", "black")
        .attr("stroke-width", 9)
        .attr("rx", 6)
        .attr("ry", 6)

    text(svg, "event-name", 20, 120, player)
}