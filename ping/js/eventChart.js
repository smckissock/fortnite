
import { cornerRadius, filters, facts, updateCounts, statsForPlayer, playerInfos } from "./main.js";
import { clearPlayer } from "./playerChart.js";
import { checkBox } from "./checkBox.js";
import { text } from "./shared.js";

export let showPlayerOnWeekChart2;

export function eventChart(id) {

    const weeks = [
        { num: 1, name: "Week 1", type: "Solo", done: true },
        { num: 2, name: "Week 2", type: "Duo", done: true },
        { num: 3, name: "Week 3", type: "Solo", done: true },
        { num: 4, name: "Week 4", type: "Duo", done: true },
        { num: 5, name: "Week 5", type: "Solo", done: true },
        { num: 6, name: "Week 6", type: "Duo", done: true },
        { num: 7, name: "Week 7", type: "Solo", done: true },
        { num: 8, name: "Week 8", type: "Duo", done: true },
        { num: 9, name: "Week 9", type: "Solo", done: true },
        { num: 10, name: "Week 10", type: "Duo", done: true },
    ];

    const events = [
        {
            format: "Solos", items: [
                { num: "W1", weekNum: 1, name: "Week 1", type: "World Cup", date: "April 14", done: true },
                { num: "W3", weekNum: 3, name: "Week 3", type: "World Cup", date: "April 28", done: true },
                { num: "W5", weekNum: 5, name: "Week 5", type: "World Cup", date: "May 12", done: true },
                { num: "W7", weekNum: 7, name: "Week 7", type: "World Cup", date: "May 26", done: true },
                { num: "W9", weekNum: 9, name: "Week 9", type: "World Cup", date: "June 9", done: true },
                { num: "F", weekNum: 11, name: "Finals", type: "World Cup", date: "June 9", done: false }
            ]
        },
        {
            format: "Duos", items: [
                { num: "W2", weekNum: 2, name: "Week 2", type: "World Cup", date: "April 21", done: true },
                { num: "W4", weekNum: 4, name: "Week 4", type: "World Cup", date: "May 5", done: true },
                { num: "W6", weekNum: 6, name: "Week 6", type: "World Cup", date: "May 19", done: true },
                { num: "W8", weekNum: 8, name: "Week 8", type: "World Cup", date: "June 2", done: true },
                { num: "W10", weekNum: 10, name: "Week 10", type: "World Cup", date: "June 21", done: true },
                { num: "F", weekNum: 11, name: "Finals", type: "World Cup", date: "June 21", done: false }
            ]
        },
        {
            format: "Trios", items: [
                { num: "W1", weekNum: 12, name: "Week 1", type: "Champion Series", date: "August 18", done: true },
                { num: "W2", weekNum: 13, name: "Week 2", type: "Champion Series", date: "August 25", done: false },
                { num: "W3", weekNum: 14, name: "Week 3", type: "Champion Series", date: "September 1", done: false },
                { num: "W4", weekNum: 15, name: "Week 4", type: "Champion Series", date: "September 8", done: false },
                { num: "W5", weekNum: 16, name: "Week 5", type: "Champion Series", date: "September 15", done: false },
                { num: "F", weekNum: 17, name: "Season Finals", type: "Champion Series", date: "September 23", done: false }
            ]
        }
    ];

    let weekSelections = [];
    
    const soloX = 10;
    const duoX = 155;

    const width = 135;
    const height = 103;
    const strokeWidthThick = 8;
    const strokeWidthThin = 4;

    const bigLabel = { x: 25, y: 59, size: "2em" };
    
    
    let checkBoxSolos;
    let checkBoxDuos;

    const div = d3.select(id);
    
    
    // Include this, and add a dimension and group
    // Later call these on a click to filter: 
    //    _chart.filter(filter);
    //    _chart.redrawGroup();
    const _chart = dc.baseMixin({});
    // This only filters. It doesn't display a group metric, and it does not respond
    // to changes in the group metric based on other filters.

    // Also - make sure to return _chart; at the end of the function, or chaining won't work! 

    const svgWidth = 1030;
    const svg = div.append("svg")
        .attr("width", svgWidth)
        .attr("height", 150);

    const corner = 6;

    function makeTimelines() {
        //const events = [
        //    {
        //        format: "Solo", items: [
        //            { num: 1, weekNum: 1, name: "Week 1", type: "World Cup", date: "April 14", done: true },
        
        const firstWeek = 1;
        const lastWeek = 18;
        const xScale = d3.scaleLinear()
            .domain([firstWeek, lastWeek])
            .range([100, svgWidth]);

        [
            { firstWeek: 1, lastWeek: 12, name: "Fortnite World Cup"},
            { firstWeek: 12, lastWeek: 18, name: "Fortnite Champion Series"}
        ]
        .forEach(function (event) {    
            const left = xScale(event.firstWeek) - 4;
            const width = xScale(event.lastWeek) - left - 5;
            
            text(svg, "event-name", left + 10, 30, event.name)
            svg.append("rect")
                .attr("x", left)
                .attr("y", 10)
                .attr("width", width)
                .attr("height", 140)
                .attr("fill-opacity", "0.0")
                .attr("stroke", "black")
                .attr("stroke-width", 1)
                .attr("rx", 8)
                .attr("ry", 8)
            });

        const top = 40;    
        let formatNum = 0;    
        events.forEach(function (format) {
            
            text(svg, "checkbox-label", 10, formatNum * 35 + 27 + top, format.format)
            let formatCheckBox = new checkBox(format.format);
            formatCheckBox
                .size(25)
                .x(62)
                .y(formatNum * 35 + 8 + top)
                .rx(corner)
                .ry(corner)
                .markStrokeWidth(4)
                .boxStrokeWidth(1)
                .checked(false)
                .clickEvent(function () {
                    checkEvent(format.format)
                });
            svg.call(formatCheckBox);

            svg.selectAll("rect." + format.format).data(format.items).enter().append("rect")
                .attr("x", d => xScale(d.weekNum))
                .attr("y", formatNum * 35 + 3 + top)
                .attr("width", 46)
                .attr("height", 34)
                .attr("fill", d => d.done == true ? "cornflowerblue" : "#888888")
                .attr("stroke", "black")
                .attr("stroke-width", 0)
                .attr("rx", 5)
                .attr("ry", 5)
                .classed(format.format, true)
                .on('mouseover', function (d) {
                    if (!d.done)
                        return;
    
                    d3.select(this)
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 3)
                })
                .on('mouseout', function (d) {
                    if (!d.done)
                        return;

                    d3.select(this)
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0);
                }).on('click', function (d) {
                    clickRect(d3.select(this), d);
                })
                .each(function(week) {
                    let x = week.num != "W10" ? xScale(week.weekNum) + 9 : xScale(week.weekNum) + 5;
                    if (week.num == "F")
                        x = xScale(week.weekNum) + 17    ;
                    text(svg, "week-label", x, formatNum * 35 + 26 + top, week.num);
                }) 
                
            formatNum++;
        })   
    } 

    const clickRect = function (d3Rect, data) {
        // Don't do anything for weeks that aren't done   
        if (data.done == false)
            return;  

        filters.soloOrDuo = "";
        //clearSoloAndDuo();

        const newFilter = "Week " + data.weekNum;

        // 5 things need to happen:

        // 1) Update filters.region
        // 2) Set/unset crossfilter filter
        // 3) Draw correct outlines
        // 4) DC Redraw
        // 5) Update counts

        // Regardless of what happens below, selected player needs to be cleared 
        clearPlayer(null);

        // 1 None were selected, this is the first selection
        if (filters.week === "") {
            filters.week = newFilter;

            _chart.filter(filters.week);
            d3Rect
                .transition()
                .duration(100)
                .attr("stroke-width", strokeWidthThick);

            _chart.redrawGroup();
            updateSquares();
            return;
        }

        // 2 One is selected, so unselect it and select this
        if (filters.week != newFilter) {
            const oldFilter = filters.week;

            // Un-border old one
            weekSelections.forEach(function (week) {
                let dom = d3.select(week.rect._groups[0][0]);
                if ("Week " + dom.attr("data") == oldFilter) {
                    // This will toggle it off
                    _chart.filter(oldFilter);
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0)
                }
            });

            filters.week = newFilter;

            _chart.filter(null);
            _chart.filter(filters.week);
            d3Rect
                .transition()
                .duration(100)
                .attr("stroke-width", 0);

            _chart.redrawGroup();
         
            updateSquares();

            return;
        }

        // 3 This was selected, so unselect it - all will be selected
        filters.week = "";
        _chart.filter(null);
        d3Rect
            .transition()
            .duration(100)
            .attr("stroke-width", 0);

        _chart.redrawGroup();
        
        // good
        //updateSquares();
    }


    function checkEvent(formatName) {
        console.log(formatName);
        return;
        const isSolo = (checkBox.getName() === "Solos");

        isSolo ? checkBoxDuos.checked(false) : checkBoxSolos.checked(false)
        filters.week = "";

        if (checkBox.checked())
            filters.soloOrDuo = isSolo ? "Solos" : "Duos";
        else
            filters.soloOrDuo = "";

        _chart.filter(null);

        if (checkBox.checked()) {
            if (isSolo) {
                _chart.filter("Week 1");
                _chart.filter("Week 3");
                _chart.filter("Week 5");
                _chart.filter("Week 7");
                _chart.filter("Week 9");
            } else {
                _chart.filter("Week 2");
                _chart.filter("Week 4");
                _chart.filter("Week 6");
                _chart.filter("Week 8");
                _chart.filter("Week 10");
            }
        }

        _chart.redrawGroup();

        updateCounts();
        updateSquares();
    }

    function updateSquares() {

        // !!
        return;

        weekSelections.forEach(function (week) {
            const solosPicked = (filters.soloOrDuo === "Solos");
            const duosPicked = (filters.soloOrDuo === "Duos");

            let strokeWidth;
            if (week.week.num % 2 == 1)
                strokeWidth = solosPicked ? strokeWidthThick : 0;
            else
                strokeWidth = duosPicked ? strokeWidthThick : 0;

            if ("Week " + week.week.num === filters.week)
                strokeWidth = strokeWidthThick;

            weekSelections[week.week.num - 1].rect
                .transition()
                .delay(week.week.num * 10)
                .duration(300)
                .attr("stroke-width", strokeWidth)
        })
    }

    
    function clearSoloAndDuo() {
        filters.soloOrDuo = "";
        _chart.filter(null);
        checkBoxSolos.checked(false);
        checkBoxDuos.checked(false);
    }

    makeTimelines(); 

    return _chart;
}
