
import { cornerRadius, filters, facts, updateCounts, statsForPlayer, playerInfos } from "./main.js";
import { clearPlayer } from "./playerChart.js";
import { checkBox } from "./checkBox.js";
import { text } from "./shared.js";


export const events = [
    {
        format: "Solos", items: [
            { num: "W1", weekNum: 1, name: "WC Week 1", type: "World Cup", date: "April 14", done: true },
            { num: "W3", weekNum: 3, name: "WC Week 3", type: "World Cup", date: "April 28", done: true },
            { num: "W5", weekNum: 5, name: "WC Week 5", type: "World Cup", date: "May 12", done: true },
            { num: "W7", weekNum: 7, name: "WC Week 7", type: "World Cup", date: "May 26", done: true },
            { num: "W9", weekNum: 9, name: "WC Week 9", type: "World Cup", date: "June 9", done: true },
            { num: "F", weekNum: 11, name: "Solo Final", type: "World Cup", date: "July 28", done: true }
        ]
    },
    {
        format: "Duos", items: [
            { num: "W2", weekNum: 2, name: "WC Week 2", type: "World Cup", date: "April 21", done: true },
            { num: "W4", weekNum: 4, name: "WC Week 4", type: "World Cup", date: "May 5", done: true },
            { num: "W6", weekNum: 6, name: "WC Week 6", type: "World Cup", date: "May 19", done: true },
            { num: "W8", weekNum: 8, name: "WC Week 8", type: "World Cup", date: "June 2", done: true },
            { num: "W10", weekNum: 10, name: "WC Week 10", type: "World Cup", date: "June 21", done: true },
            { num: "F", weekNum: 11, name: "Duo Final", type: "World Cup", date: "July 27", done: true }
        ]
    },
    {
        format: "Trios", items: [
            { num: "W1", weekNum: 12, name: "CS Week 1", type: "Champion Series", date: "August 18", done: true },
            { num: "W2", weekNum: 13, name: "CS Week 2", type: "Champion Series", date: "August 25", done: true },
            { num: "W3", weekNum: 14, name: "CS Week 3", type: "Champion Series", date: "September 1", done: true },
            { num: "W4", weekNum: 15, name: "CS Week 4", type: "Champion Series", date: "September 8", done: true },
            { num: "W5", weekNum: 16, name: "CS Week 5", type: "Champion Series", date: "September 15", done: true },
            { num: "F", weekNum: 17, name: "CS Final", type: "Champion Series", date: "September 22", done: true }
        ]
    }
];


export function eventChart(id) {

    let weekSelections = [];

    let weekRects = [];

    const soloX = 10;
    const duoX = 155;

    const width = 135;
    const height = 103;
    const strokeWidthThick = 4;
    const strokeWidthThin = 2;

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
        
        const firstWeek = 1;
        const lastWeek = 18;
        const xScale = d3.scaleLinear()
            .domain([firstWeek, lastWeek])
            .range([76, svgWidth]);

        [
            { firstWeek: 1, lastWeek: 12, name: "Fortnite World Cup" },
            { firstWeek: 12, lastWeek: 18, name: "Fortnite Champion Series" }
        ]
            .forEach(function (event) {
                const left = xScale(event.firstWeek) - 4;
                const width = xScale(event.lastWeek) - left - 5;

                text(event.name, svg, "event-name", left + 10, 30)
                svg.append("rect")
                    .attr("x", left)
                    .attr("y", 10)
                    .attr("width", width)
                    .attr("height", 140)
                    .attr("fill-opacity", "0.0")
                    .attr("stroke", "black")
                    .attr("stroke-width", 1)
                    //.attr("rx", 8)
                    //.attr("ry", 8)
            });

        const top = 40;
        let formatNum = 0;
        events.forEach(function (format) {

            text(format.format, svg, "checkbox-label", 10, formatNum * 35 + 27 + top)
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
                    formatCheck(format.format, formatCheckBox.checked())
                });
            // Maybe later...    
            //svg.call(formatCheckBox);

            svg.selectAll("rect." + format.format).data(format.items).enter().append("rect")
                .attr("x", d => xScale(d.weekNum))
                .attr("y", formatNum * 35 + 3 + top)
                .attr("width", 46)
                .attr("height", 34)
                .attr("fill", d => d.done == true ? "cornflowerblue" : "#888888")
                .attr("stroke", "black")
                .attr("stroke-width", 0)
                //.attr("rx", 5)
                //.attr("ry", 5)
                .classed(format.format, true)
                .on('mouseover', function (d) {
                    if (!d.done)
                        return;

                    d3.select(this)
                        .transition()
                        .duration(100)
                        .attr("stroke-width", strokeWidthThin)
                })
                .on('mouseout', function (d) {
                    if (!d.done)
                        return;

                    drawWeekBorders()
                }).on('click', function (d) {
                    clickRect(d3.select(this), d);
                })
                .each(function (week) {
                    weekRects.push(d3.select(this));

                    let x = week.num != "W10" ? xScale(week.weekNum) + 11 : xScale(week.weekNum) + 7;
                    if (week.num == "F")
                        x = xScale(week.weekNum) + 17;
                    text(week.num, svg, "week-label", x, formatNum * 35 + 25 + top);
                })

            formatNum++;
        })
    }

    const clickRect = function (d3Rect, data) {
        // Don't do anything for weeks that aren't done   
        if (data.done == false)
            return;

        function refresh() {
            _chart.redrawGroup();
            drawWeekBorders();
        }

        filters.soloOrDuo = "";
        //clearSoloAndDuo();

        //const newFilter = "Week " + data.weekNum;
        const newFilter = data.name;

        // 5 things need to happen:

        // 1) Update filters.region
        // 2) Set/unset crossfilter filter
        // 3) Draw correct outlines
        // 4) DC Redraw
        // 5) Update counts

        // Regardless of what happens below, selected player needs to be cleared 
        clearPlayer(null);

        // 1 None were selected, this is the first selection
        if (filters.weeks.length === 0) {
            filters.weeks.push(newFilter);

            _chart.filter(filters.weeks[0]);
            refresh();
            return;
        }

        // An unselected rect was clicked, so add it.
        if (filters.weeks.indexOf(newFilter) == -1) {
            filters.weeks.push(newFilter);

            _chart.filter([[newFilter]]);
            refresh();
            return;
        }

        // 3 This was already selected, so toggle it off 
        filters.weeks = filters.weeks.filter(d => d !== newFilter)

        _chart.filter([[newFilter]]);
        refresh();
    }


    // Checks for solo, dou and trio are hidden at the moment
    function formatCheck(formatName, checked) {
        console.log(formatName + " " + checked);
        return;

        _chart.redrawGroup();
        drawWeekBorders();
        updateCounts();
    }

    function drawWeekBorders() {
        weekRects.forEach(function (week) {
            const data = week.data()[0];

            const strokeWidth = (filters.weeks.indexOf(data.name) != -1) ? strokeWidthThick : 0;

            week
                .transition()
                .duration(100)
                .attr("stroke-width", strokeWidth);
        });
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
