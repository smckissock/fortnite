// @language_out ecmascript5

import {colors} from "./shared.js";

import {filters, facts, updateCounts} from "./main.js";
import {clearPlayer} from "./playerChart.js";

export let clearTeam;
export let updateTeamBars; 


export function teamChart(id, teamDim, teamGroup) {

    const dim = teamDim;
    const group = teamGroup;

    const div = d3.select(id);

    const _chart = dc.baseMixin({});
    
    const leftMargin = 4; 
    const chartWidth = 180;

    const titleHeight = 34;
    const barHeight = 26;
    const teamCount = group.all().length;

    const duration = 10;

    const strokeWidthThin = 3;
    const strokeWidthThick = 5;

    let groups;

    let selectedTeam = {
        name: "", 
        rect: null, 
        n: -1
    };

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

    clearTeam = resetTeam;

    return _chart;
    
    function drawTitle() {
        svg.append("text")
            .attr("x", 10)
            .attr("y", 20)
            .text("Teams")
            .attr("font-size", "1.8em")
            .attr("fill", "black");
    } 
    
    function drawBars() {
        
        let n = 0;
        group.all().forEach(function(d) {
            svg.append("rect")
                //.attr("data", d)
                .attr("x", leftMargin)
                .attr("y", titleHeight + (n * barHeight))
                .attr("width", 0)
                .attr("height", barHeight - 5)
                .attr("fill", "lightblue")
                .attr("stroke", "black")
                .style("stroke-width", 0)
                .attr("rx", 5)
                .attr("ry", 5)
                .classed("teamRect" + n, true)
                .on("mouseover", function () {
                    const node = d3.select(this);
                    const team = node.attr("data");
                    
                    // This is selected, so keep the thick border
                    if (filters.team == team)
                        return;   
                        
                    node
                        .transition()
                        .duration(duration)
                        .style("stroke-width", strokeWidthThin)
                })
                .on("mouseout", function () {
                    const node = d3.select(this);
                    const team = node.attr("data");
                    
                    // This is selected, so keep the thick border
                    if (filters.team === team)
                        return;
                  
                    node
                        .transition()
                        .duration(duration)
                        .style("stroke-width", 0) 
                })
                .on('click', function (d) {
                    clickRect(d3.select(this));
                });

            svg.append("text")
                .attr("x", 8)
                .attr("y", titleHeight + (n * barHeight) + 15)
                .text("")
                .attr("font-weight", 600)
                .style("font-family", "Helvetica, Arial, sans-serif")
                .attr("font-size", ".8em")
                .attr("fill", "black")
                .attr("pointer-events", "none")
                .classed("teamText" + n, true); 
            n++;
        });
    }


    function clickRect(rect) {
        const team = rect.attr("data");
        
        const oldTeam = selectedTeam;
        selectedTeam = {
            name: team,
            rect: rect
        } 

        // 5 things need to happen:

        // 1) Update filters.team
        // 2) Set/unset crossfilter filter
        // 3) Draw correct outlines
        // 4) DC Redraw
        // 5) Update counts

        // Regardless of what happens below, selected player needs to be cleared 
        clearPlayer(null);

        // 1 None were selected, this is the first selection
        if (filters.team === "") {
            filters.team = selectedTeam.name;
            
            rect
                .transition()
                .duration(duration)
                .style("stroke-width", strokeWidthThick);

            _chart.filter(filters.team);
            _chart.redrawGroup();  
            
            updateCounts();

            //moveCursor(false);

            return;
        }

        // 2 One is selected, so unselect it and select this
        if (filters.team != selectedTeam.name) {
            
            // Un-border old one
            oldTeam.rect
                .transition()
                .duration(duration)
                .style("stroke-width", 0)

            rect
                .transition()
                .duration(duration)
                .style("stroke-width", strokeWidthThick);

            filters.team = selectedTeam.name;
            
            _chart.filter(null);
            _chart.filter(filters.team);
            _chart.redrawGroup();   

            //moveCursor(false); 
            return;
        }   

        // 3 This was selected, so unselect it - none will be selected
        rect
            .transition()
            .duration(duration)
            .style("stroke-width", 0); 

        _chart.filter(null);
        _chart.redrawGroup();
        filters.team = "";    

        selectedTeam = {
            name: '',
            rect: null
        } 
    }


    // When data changes, rezise bars and change text 
    function updateBars() {

        const commaFormat = d3.format(","); 

        // Must clone groups. If you reorder them in place, crossfilter will give the wrong answers 
        const groupsClone = [...group.all()];
        groups = groupsClone
            .sort((a, b) => b.value - a.value)
            .filter(team => (team.key != "Free Agent") && (team.key != "")); 

        const scale = d3.scaleLinear()
            .domain([0, groups[0].value])
            .range([leftMargin, chartWidth - (leftMargin * 2)]);

        let n = 0;
        groups.forEach(function(d) {
            d3.select(".teamRect" + n)
                .attr("data", d.key)
                .transition()
                .duration(200)
                .attr("width", d.value == 0 ? 0 : scale(d.value));

            const txt = d3.select(".teamText" + n);    
            const oldText = txt.text();
            const newText = d.value == 0 ? "" : d.key + ' $' + commaFormat(d.value); 

            txt.text(newText);

            //if (oldText != "" && newText == "")
            //    txt.Text(newText);
                
                
            //d3.select(".teamText" + n)
            //    .text(d.key + ' $' + commaFormat(d.value));    
 
            n++;
        });
    }

    function resetTeam() {
        if (selectedTeam.rect !== null)
            selectedTeam.rect
                .transition()
                .duration(duration)
                .style("stroke-width", 0)
                
        selectedTeam = {
            name: "", 
            rect: null, 
            n: -1
        };
        
        filters.team = "";
        _chart.filter(null);
        //_chart.redrawGroup();
    }
}