import {colors} from "./shared.js";

import {filters} from "./main.js";
import {clearPlayer} from "./playerChart.js";


export function teamChart(id) {

    const div = d3.select(id);

    const _chart = dc.baseMixin({});

    const svg = div.append("svg")
        .attr("width", 180)
        .attr("height", 800);
    
    svg.append("text")
        .attr("x", 14)
        .attr("y", 20)
        .text("Teams")
        .attr("font-size", "1.8em")
        .attr("fill", "black"); 


    return _chart;
}
