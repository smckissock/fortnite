
import { cornerRadius, filters, facts, updateCounts, statsForPlayer, playerInfos } from "./main.js";
import { clearPlayer } from "./playerChart.js";
import { checkBox } from "./checkBox.js";

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
            format: "Solo", items: [
                { num: 1, weekNum: 1, name: "Week 1", type: "World Cup", date: "April 14", done: true },
                { num: 3, weekNum: 3, name: "Week 3", type: "World Cup", date: "April 28", done: true },
                { num: 5, weekNum: 5, name: "Week 5", type: "World Cup", date: "May 12", done: true },
                { num: 7, weekNum: 7, name: "Week 7", type: "World Cup", date: "May 26", done: true },
                { num: 9, weekNum: 9, name: "Week 9", type: "World Cup", date: "June 9", done: true }
            ]
        },
        {
            format: "Duo", items: [
                { num: 2, weekNum: 2, name: "Week 2", type: "World Cup", date: "April 21", done: true },
                { num: 4, weekNum: 4, name: "Week 4", type: "World Cup", date: "May 5", done: true },
                { num: 6, weekNum: 6, name: "Week 6", type: "World Cup", date: "May 19", done: true },
                { num: 8, weekNum: 8, name: "Week 8", type: "World Cup", date: "June 2", done: true },
                { num: 10, weekNum: 11, name: "Week 10", type: "World Cup", date: "June 21", done: true }
            ]
        },
        {
            format: "Trio", items: [
                { num: 1, weekNum: 19, name: "Week 1", type: "Champion Series", date: "August 18", done: true },
                { num: 2, weekNum: 20, name: "Week 2", type: "Champion Series", date: "August 25", done: false },
                { num: 3, weekNum: 21, name: "Week 3", type: "Champion Series", date: "September 1", done: false },
                { num: 4, weekNum: 22, name: "Week 4", type: "Champion Series", date: "September 8", done: false },
                { num: 5, weekNum: 23, name: "Week 5", type: "Champion Series", date: "September 15", done: false },
                { num: 5, weekNum: 24, name: "Season Finals", type: "Champion Series", date: "September 23", done: false }
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
    const divPlayer = d3.select("#chart-weeks-player");

    
    // Include this, and add a dimension and group
    // Later call these on a click to filter: 
    //    _chart.filter(filter);
    //    _chart.redrawGroup();
    const _chart = dc.baseMixin({});
    // This only filters. It doesn't display a group metric, and it does not respond
    // to changes in the group metric based on other filters.

    // Also - make sure to return _chart; at the end of the function, or chaining won't work! 

    const svg = div.append("svg")
        .attr("width", 300)
        .attr("height", (height * 5) + 50);

    const corner = 6;

    
    svg.append("text")
        .attr("x", 25)
        .attr("y", 24)
        .text("Solos")
        .attr("font-size", "1.9em")
        .attr("fill", "black");

    checkBoxSolos = new checkBox("Solos");
    checkBoxSolos
        .size(27)
        .x(100)
        .y(2)
        .rx(corner)
        .ry(corner)
        .markStrokeWidth(6)
        .boxStrokeWidth(2)
        .checked(false)
        .clickEvent(function () {
            checkEvent(checkBoxSolos)
        });
    svg.call(checkBoxSolos);


    svg.append("text")
        .attr("x", duoX + 15)
        .attr("y", 24)
        .text("Duos")
        .attr("font-size", "1.9em")
        .attr("fill", "black");

    checkBoxDuos = new checkBox("Duos");
    checkBoxDuos
        .size(27)
        .x(duoX + 100)
        .y(2)
        .rx(corner)
        .ry(corner)
        .markStrokeWidth(6)
        .boxStrokeWidth(2)
        .checked(false)
        .clickEvent(function () {
            checkEvent(checkBoxDuos)
        });
    svg.call(checkBoxDuos);


    function checkEvent(checkBox) {
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


    const top = 40;
    let count = 0;
    weeks.forEach(function (week) {

        let weekSelection = {};

        const x = week.type === "Solo" ? soloX : duoX;
        const y = Math.round((count - 1) / 2) * height + top;

        const grey = '#606060';

        let color = (week.type === "Duo") ? "lightblue" : "lightblue";
        if (!week.done)
            color = grey;

        const rect = svg.append("rect")
            .attr("data", week.num)
            .attr("x", x)
            .attr("y", y)
            .attr("width", width)
            .attr("height", height - 10)
            .attr("fill", color)
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("rx", cornerRadius)
            .attr("ry", cornerRadius)

            .on('mouseover', function (d) {
                const num = d3.select(this).attr("data");

                // They are mousing over the selected item - don't shrink the border
                if ("Week " + num === filters.week)
                    return;

                // Don't do anything for weeks that aren't done     
                if (!weeks.filter(x => x.num == num)[0].done)
                    return;

                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", strokeWidthThin)
            })
            .on('mouseout', function (d) {
                let dom = d3.select(this);

                // Solos are selected and this is a solo week, so ignore     
                if ((dom.attr("data") % 2 === 1) && (filters.soloOrDuo === "Solos")) {
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", strokeWidthThick);
                    return;
                }

                // Duos are selected and this is a solo week, so ignore     
                if ((dom.attr("data") % 2 === 0) && (filters.soloOrDuo === "Duos")) {
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", strokeWidthThick);
                    return;
                }

                if ("Week " + dom.attr("data") != filters.week)
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0);
            })
            .on('click', function (d) {
                clickRect(d3.select(this));
            });
        weekSelection.rect = rect;

        const label = svg.append("text")
            .attr("x", x + bigLabel.x)
            .attr("y", y + bigLabel.y)
            .text("Week " + (count + 1))
            .attr("font-size", bigLabel.size)
            .attr("fill", "black")
            .attr("pointer-events", "none");

        const noPlaceLabel = svg.append("text")
            .attr("x", x + 34)
            .attr("y", y + bigLabel.y + 8)
            .text("No Payout")
            .style("font-family", "Helvetica, Arial, sans-serif")
            .attr("font-size", "0.8em")
            .attr("fill", "black")
            .attr("fill-opacity", 0)
            .attr("pointer-events", "none");

        weekSelection.week = week;

        count++;
    });

    
    function clearSoloAndDuo() {
        filters.soloOrDuo = "";
        _chart.filter(null);
        checkBoxSolos.checked(false);
        checkBoxDuos.checked(false);
    }

    const clickRect = function (d3Rect) {
        const num = d3Rect.attr("data");

        // Don't do anything for weeks that aren't done     
        if (!weeks.filter(x => x.num == num)[0].done)
            return;

        filters.soloOrDuo = "";
        clearSoloAndDuo();

        const newFilter = "Week " + num;

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

            selectedRect = d3Rect;
            //moveCursor(false);
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

            selectedRect = d3Rect;            
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

        selectedRect = d3Rect;
        updateSquares();
    }


    return _chart;
}
