import {colors} from "./shared.js";

import {filters} from "./main.js";
import {clearPlayer} from "./playerChart.js";

export let updateTeamBars; 


export function teamChart(id, teamDim, teamGroup) {

    const dim = teamDim;
    const group = teamGroup;

    const div = d3.select(id);

    const _chart = dc.baseMixin({});
    
    const leftMargin = 10; 
    const chartWidth = 180;

    const titleHeight = 34;
    const barHeight = 26;
    const teamCount = group.all().length;

    console.log(teamCount);

    const svg = div.append("svg")
        .attr("width", chartWidth)
        .attr("height", titleHeight + (barHeight * teamCount));
    
    drawTitle();
    drawBars();
    updateBars();

    // For export
    updateTeamBars = updateBars;

    // DC related stuff
    _chart._doRender = function () {
        updateBars();
        return _chart;
    };

    _chart._doRedraw = function () {
        return _chart._doRender();
    };

    return _chart;
    
    function drawTitle() {
        svg.append("text")
            .attr("x", 14)
            .attr("y", 20)
            .text("Teams")
            .attr("font-size", "1.8em")
            .attr("fill", "black");
    } 
    
    function drawBars() {
        
        let n = 0;
        group.all().forEach(function(d) {
            svg.append("rect")
                .attr("data", n)
                .attr("x", leftMargin)
                .attr("y", titleHeight + (n * barHeight))
                .attr("width", 0)
                .attr("height", barHeight - 5)
                .attr("fill", "lightblue")
                .attr("stroke", "black")
                .attr("stroke-width", 0)
                .attr("rx", 5)
                .attr("ry", 5)
                .classed("teamRect" + n, true)

            svg.append("text")
                .attr("x", 14)
                .attr("y", titleHeight + (n * barHeight) + 15)
                .text("")
                //.text(d.key)
                .style("font-family", "Helvetica, Arial, sans-serif")
                .attr("font-size", ".8em")
                .attr("fill", "black")
                .classed("teamText" + n, true); 
            n++;
            //console.log(d.key + '' + d.value);
        });
    }

    function updateBars() {

        const commaFormat = d3.format(","); 

        const groups = group.all()
            .sort((a, b) => b.value - a.value)
            .filter(team => team.key != "Free Agent"); 

        const scale = d3.scaleLinear()
            .domain([0, groups[0].value])
            .range([leftMargin, chartWidth - (leftMargin * 2)]);

        let n = 0;
        groups.forEach(function(d) {
            d3.select(".teamRect" + n)
                .transition()
                .duration(400)
                .attr("width", scale(d.value));

            d3.select(".teamText" + n)
                .text(d.key + ' ' + commaFormat(d.value));    
 
            n++;
        });
    }
}





