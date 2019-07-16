// @language_out ecmascript5

import { colors } from "./shared.js";

import { cornerRadius, filters, playerDim, playerColors, soloQualifications, duoQualifications, qualifierNames, updateCounts, teamMembers, showPlayerProfile } from "./main.js";
import { showPlayerOnWeekChart } from "./weekChart.js";
import { d3CheckBox } from "./d3CheckBox.js";

export let clearPlayer
export let PlayerTableWidth;
export let playerData;

export let showingScatterplot = false;

export let playerChart_renderPlayerPage;


export function playerChart(id) {

    const showScatterplotButton = true;

    const noFormat = function (d) { return d; }
    const commaFormat = d3.format(",");
    const pctFormat = d3.format(",.1%");
    const pctAxisFormat = d3.format(",.0%");
    const moneyFormat = function (d) { return "$" + d3.format(",")(d); };
    const moneyKFormat = d3.format(".2s");

    const columns = [
        { name: "Players", code: "player", x: 86, format: noFormat, axisFormat: noFormat },
        { name: "Rank", code: "rank", x: 16, format: noFormat, axisFormat: noFormat },
        { name: "Payout", code: "payout", x: 9, format: commaFormat, format: commaFormat, axisFormat: moneyKFormat },
        { name: "Points", code: "points", x: 13, format: noFormat, axisFormat: noFormat },
        { name: "Wins", code: "wins", x: 17, format: noFormat, axisFormat: noFormat },
        { name: "Earned Quals", code: "earnedQualifications", x: 0, format: noFormat, axisFormat: noFormat },
        { name: "Elims", code: "elims", x: 15, format: noFormat, axisFormat: noFormat },
        { name: "Elim %", code: "elimPercentage", x: 16, format: pctFormat, axisFormat: pctAxisFormat },
        { name: "Placement", code: "placementPoints", x: 0, format: noFormat, axisFormat: noFormat },
        { name: "Placement %", code: "placementPercentage", x: 0, format: pctFormat, axisFormat: pctAxisFormat }
    ];

    const regions = [
        { color: colors.green, filter: "NA East" },
        { color: colors.purple, filter: "NA West" },
        { color: colors.blue, filter: "Europe" },
        { color: colors.red, filter: "Oceania" },
        { color: colors.teal, filter: "Brazil" },
        { color: colors.brown, filter: "Asia" }
    ];

    const headerPos = { left: 150, top: 0, height: 69, width: 80, gap: 5 };

    const playerColWidth = 240;
    PlayerTableWidth = playerColWidth + (headerPos.width * (columns.length - 1) + 4);

    const _chart = dc.baseMixin({});

    const top = headerPos.height + 14;
    const rowHeight = 36;
    const rowCount = 20;

    const thinBorder = 3;
    const thickBorder = 7;

    let numOrRankRect;
    let numOrRankText;

    let upArrowPolygon;
    let downArrowPolygon;

    let scatterplotButton;

    // Whether the scatterplot button is clicked, and we see a scatterplot instead of a table
    //let showingScatterplot = false;


    let svgWidth = PlayerTableWidth; //640;

    // Ugh - currently selected rect, so it can be unselected easily
    let selectedRect;

    // The data currently displayed, in order 
    let playerRows = [];

    let xScale = null;
    let yScale = null;
    let xAxis = null;
    let yAxis = null;

    filters.yMeasure = columns[2] // payout
    filters.xMeasure = columns[7] // elimPercentage


    // Important!!
    // baseMixin has mandatory ['dimension', 'group'], but we don't have a group here. 
    _chart._mandatoryAttributes(['dimension']);


    const div = d3.select(id);

    // The selection rect what moves around when the current sort column changes
    let cursor;

    // The selection rect what moves around when the current player changes
    let playerCursor;
    let playerCursorVisible = false;

    // Controls filter for "World Cup Only"
    let worldCupOnlyCheckBox;

    let rows = [];
    for (let i = 0; i < rowCount; i++)
        rows.push({ num: i });

    const svg = div.append("svg")
        .attr("width", svgWidth + 4)
        .attr("height", 1000)

    drawHeaders(svg);
    drawRows(svg);

    const scatterplotBox = svg.append("g");
    const scatterplotSvg = scatterplotBox.append("svg")
        .attr("width", svgWidth + 4)
        .attr("height", 800)
        .attr("transform", "translate(0,200)")

    const corner = 6;
    const scatterplotRect = scatterplotSvg.append("rect")
        .attr("x", 3)
        .attr("y", 84)
        .attr("width", svgWidth - 6)
        .attr("height", 746)
        .attr("fill", "#F0F8FF")
        .attr("stroke", "black")
        .attr("stroke-width", 8)
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)
        .attr("opacity", "0")
        .attr("pointer-events", "none");


    function scatterplotButtonText() {

        function addText(x, y, text) {
            svg.append("text")
                .attr("x", x)
                .attr("y", y)
                .attr("fill", "black")
                .attr("stroke", "black")
                .text(text)
                //.attr("font-family", "burbank")
                .attr("font-size", "1.2em")
                .attr("pointer-events", "none")
                .attr("font-weight", 300)
                .classed("scatterplotButton-" + text, true)
        }
        addText(playerColWidth - 218, headerPos.top + 32, "Show");
        addText(playerColWidth - 230, headerPos.top + 54, "Listing");
        addText(playerColWidth - 221, headerPos.top + 54, "Chart");

        if (showingScatterplot) {
            svg.select(".scatterplotButton-Listing").text("Listing");
            svg.select(".scatterplotButton-Chart").text("");
        } else {
            svg.select(".scatterplotButton-Listing").text("");
            svg.select(".scatterplotButton-Chart").text("Chart");
        }

        // Temporary - only while chart is turned on 
        if (!showScatterplotButton) {
            svg.select(".scatterplotButton-Show").text("");
            svg.select(".scatterplotButton-Listing").text("");
            svg.select(".scatterplotButton-Chart").text("");
        }
    }

    function drawHeaders() {

        function tableHeaderClick(d, elm) {

            // They clicked on the selected one, so just ignore
            if (d.code === filters.sort)
                return;

            // Unselect the old one    
            drawColumnBorder(filters.sort, 0);

            filters.sort = d.code;
            d3.select(elm)
                .transition()
                .duration(100)
                .attr("stroke-width", 0);

            if (filters.player != "")
                setPlayer(null);

            renderRows();
            moveCursor(elm);
        }

        function scatterplotHeaderClick(d, elm) {

            // Replaces closest previously-selected column with the newly-selected column 
            function setSelectedColumn(newSelectedIndex) {
                let space = 1;
                let done = false;
                while (!done) {
                    // Check to the right 
                    let idx = newSelectedIndex + space;
                    if ((idx < columns.length) && (idx > 0)) {
                        if (columns[idx].code == filters.xMeasure.code) {
                            filters.xMeasure = columns[newSelectedIndex];
                            break;
                        }
                        if (columns[idx].code == filters.yMeasure.code) {
                            filters.yMeasure = columns[newSelectedIndex];
                            break;
                        }
                    }
                    // Check to the left
                    idx = newSelectedIndex - space;
                    if ((idx < columns.length) && (idx > 0)) {
                        if (columns[idx].code == filters.xMeasure.code) {
                            filters.xMeasure = columns[newSelectedIndex];
                            break;
                        }
                        if (columns[idx].code == filters.yMeasure.code) {
                            filters.yMeasure = columns[newSelectedIndex];
                            break;
                        }
                    }
                    space++;
                }
            }

            // They clicked on one that was already selected
            if ((d.code === filters.xMeasure.code) || (d.code === filters.yMeasure.code))
                return;

            // Set the new filter. Unselect the selected filter which is nearer to it
            // One way to find index of item in columns 
            let newSelectedIndex = 0;
            let i = 0;
            columns.forEach(function (x) {
                if (x.code === d.code)
                    newSelectedIndex = i;
                i++;
            });
            //console.log("BEFORE: " + filters.xMeasure.code + " " + filters.yMeasure.code);
            setSelectedColumn(newSelectedIndex);
            //console.log("AFTER: " + filters.xMeasure.code + " " + filters.yMeasure.code);
            //console.log("");

            // Remove borders on unselected, add borders on selected
            columns.forEach(function (d) {
                d.elm
                    //.transition()
                    .style("stroke-width", ((d.code === filters.xMeasure.code) || (d.code === filters.yMeasure.code)) ? thickBorder : 0);
            })

            updateScatterplot();
        }


        // Button on top left to switch between table and scatterplot
        function makeScatterplotButton() {

            scatterplotButton = svg.append("rect")
                .attr("x", playerColWidth - 236)
                .attr("y", headerPos.top + 4)
                .attr("width", headerPos.width - headerPos.gap - 3)
                .attr("height", headerPos.height)
                .attr("fill", "lightblue")
                .attr("stroke", "black")
                .attr("stroke-width", 1)
                .attr("rx", cornerRadius)
                .attr("ry", cornerRadius)
                .on('mouseover', function (d) {
                    d3.select(this)
                        .transition()
                        .duration(100)
                        .attr("stroke-width", thinBorder);
                })
                .on('mouseout', function (d) {
                    d3.select(this)
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0);
                })
                .on('click', function (d) {
                    toggleTableAndScatterplot();
                });

            scatterplotButtonText();
        }

        // Rects for column headers 
        svg.selectAll("rect").data(columns).enter().append("rect")
            .attr("x", (d, i) => (i == 0) ? 0 : playerColWidth + headerPos.gap + (headerPos.width * (i - 1)))
            .attr("y", headerPos.top + 4)
            .attr("width", (d, i) => (i == 0) ? playerColWidth : headerPos.width - headerPos.gap - 3) // -3 because right-most was having its right border cup off 
            .attr("height", headerPos.height)
            .attr("fill", (d, i) => (i == 0) ? "none" : "lightblue")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("data", d => d)
            .attr("rx", cornerRadius)
            .attr("ry", cornerRadius)
            .on('mouseover', function (d) {
                // The are mousing over the selected item - don't show a thin border, leave it thick
                if (d.code === filters.sort)
                    return;

                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", thinBorder);
            })
            .on('mouseout', function (d) {
                // The are leaving the selected item - don't shrink the border
                if (d.code === filters.sort)
                    return;

                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 0);
            })
            .on('click', function (d) {
                if (showingScatterplot)
                    scatterplotHeaderClick(d, this);
                else
                    tableHeaderClick(d, this);
            })
            .each(function (d, i) {

                // Link elm back to data for later use
                d.elm = d3.select(this);

                if (i === 1) {
                    numOrRankRect = d3.select(this);
                }
            });

        columnHeaderText();
        pageArrows();

        if (showScatterplotButton)
            makeScatterplotButton();

        drawColumnBorder("payout", thickBorder);

        // Make this after the the player rects so that always appears "on top"
        cursor = svg.append("rect")
            .attr("x", playerColWidth + headerPos.gap + headerPos.width)
            .attr("y", headerPos.top + 4)
            .attr("width", headerPos.width - headerPos.gap - 3)
            .attr("height", headerPos.height)
            .attr("fill", "none")
            .attr("stroke", "black")
            .attr("stroke-width", thickBorder)
            .attr("pointer-events", "none")
            .attr("rx", cornerRadius)
            .attr("ry", cornerRadius)
    }

    function moveCursor(rect) {
        const x = rect.x.baseVal.value;
        const y = rect.y.baseVal.value;

        cursor
            .transition()
            .ease(d3.easeBack)
            .duration(600)
            .attr("x", x)
            .attr("y", y);
    }


    function columnHeaderText() {

        function addText(i) {

            const text = columns[i].name;
            const fontSize = (i === 0) ? "2.2em" : "1.3em";
            const x = (i === 0) ? columns[i].x : playerColWidth + headerPos.gap + (headerPos.width * (i - 1)) + columns[i].x;

            const smallFontSize = "1.0em";
            const mediumFontSize = "1.2em";

            // Earned Quals
            if (text === "Earned Quals") {
                svg.append("text")
                    .attr("x", x + 12)
                    .attr("y", 34)
                    .text("Earned")
                    .attr("font-family", "burbank")
                    .attr("font-size", mediumFontSize)
                    .attr("fill", "black")
                    .attr("pointer-events", "none");

                svg.append("text")
                    .attr("x", x + 16)
                    .attr("y", 58)
                    .text("Quals")
                    .attr("font-family", "burbank")
                    .attr("font-size", mediumFontSize)
                    .attr("fill", "black")
                    .attr("pointer-events", "none");
                return;
            }

            // Elim Points
            if (text === "Elims") {
                svg.append("text")
                    .attr("x", x + 8)
                    .attr("y", 34)
                    .text("Elim")
                    .attr("font-family", "burbank")
                    .attr("font-size", mediumFontSize)
                    .attr("fill", "black")
                    .attr("pointer-events", "none");

                svg.append("text")
                    .attr("x", x)
                    .attr("y", 58)
                    .text("Points")
                    .attr("font-family", "burbank")
                    .attr("font-size", mediumFontSize)
                    .attr("fill", "black")
                    .attr("pointer-events", "none");
                return;
            }

            // Elim %
            if (text === "Elim %") {
                svg.append("text")
                    .attr("x", x + 5)
                    .attr("y", 35)
                    .text("Elim")
                    .attr("font-family", "burbank")
                    .attr("font-size", mediumFontSize)
                    .attr("fill", "black")
                    .attr("pointer-events", "none");

                svg.append("text")
                    .attr("x", x + 10)
                    .attr("y", 60)
                    .text("%")
                    .attr("font-family", "burbank")
                    .attr("font-size", "1.5em")
                    .attr("fill", "black")
                    .attr("pointer-events", "none");
                return;
            }

            // Placement Points
            if (text === "Placement") {
                svg.append("text")
                    .attr("x", x + 5)
                    .attr("y", 34)
                    .text("Placement")
                    .attr("font-family", "burbank")
                    .attr("font-size", smallFontSize)
                    .attr("fill", "black")
                    .attr("pointer-events", "none");

                svg.append("text")
                    .attr("x", x + 15)
                    .attr("y", 55)
                    .text("Points")
                    .attr("font-family", "burbank")
                    .attr("font-size", smallFontSize)
                    .attr("fill", "black")
                    .attr("pointer-events", "none");
                return;
            }

            // Placement %
            if (text === "Placement %") {
                svg.append("text")
                    .attr("x", x + 5)
                    .attr("y", 34)
                    .text("Placement")
                    .attr("font-family", "burbank")
                    .attr("font-size", smallFontSize)
                    .attr("fill", "black")
                    .attr("pointer-events", "none");

                svg.append("text")
                    .attr("x", x + 25)
                    .attr("y", 59)
                    .text("%")
                    .attr("font-family", "burbank")
                    .attr("font-size", "1.5em")
                    .attr("fill", "black")
                    .attr("pointer-events", "none");
                return;
            }

            // Default case
            const y = (i === 0) ? 32 : 44; // Player
            const node = svg.append("text")
                .attr("x", x)
                .attr("y", y)
                .text(text)
                .attr("font-family", "burbank")
                .attr("font-size", fontSize)
                .attr("fill", "black")
                .attr("pointer-events", "none");

            if (text === "Rank")
                numOrRankText = node;
        }

        let i = 0;
        columns.forEach(function () {
            addText(i);
            i++;
        });

        if (numOrRankRect)
            numOrRankRect
                .attr("stroke-width", (filters.week && (filters.sort === "rank")) ? thickBorder : 0);

        drawWorldCupOnly();
    }

    function drawWorldCupOnly() {
        svg.append("text")
            .attr("x", 81)
            .attr("y", 58)
            .text("World Cup")
            .classed("world-cup-only-check", true);

        svg.append("text")
            .attr("x", 121)
            .attr("y", 73)
            .text("Only")
            .classed("world-cup-only-check", true);

        worldCupOnlyCheckBox = new d3CheckBox("X");
        worldCupOnlyCheckBox
            .size(27)
            .x(158)
            .y(46)
            .rx(cornerRadius)
            .ry(cornerRadius)
            .markStrokeWidth(6)
            .boxStrokeWidth(2)
            .checked(filters.worldCupOnly)
            .clickEvent(toggleWorldCupOnly)
        svg.call(worldCupOnlyCheckBox);
    }

    function toggleWorldCupOnly() {
        filters.worldCupOnly = !filters.worldCupOnly;
        renderRows();
        updateCounts();
    }

    // Draw triangles to change page 
    function pageArrows() {
        const width = 50;
        const height = headerPos.height / 2;

        upArrowPolygon = svg.append("polygon")
            .attr("points", (playerColWidth - width) + "," + (height - 2) + " " + playerColWidth + "," + (height - 2) + " " + (playerColWidth - (width / 2)) + "," + 4)
            .style("fill", "#F0F8FF")
            .attr("pointer-events", "bounding-box")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .on('mouseover', function (d) {
                d3.select(this)
                    .attr("stroke-width", 5)
            })
            .on('mouseout', function (d) {
                d3.select(this)
                    .attr("stroke-width", 0)
            }).on('click', function (d) {
                setPlayer(null);
                nextPage("up");
            });

        downArrowPolygon = svg.append("polygon")
            .attr("points", (playerColWidth - width) + "," + (height + 5) + " " + playerColWidth + "," + (height + 5) + " " + (playerColWidth - (width / 2)) + "," + (height * 2))
            .style("fill", "#F0F8FF")
            .attr("pointer-events", "bounding-box")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            //.attr("stroke-linejoin", "bevel") // it would be nice to have round corners, but this doesn't work
            .on('mouseover', function (d) {
                d3.select(this)
                    .attr("stroke-width", 5)
            })
            .on('mouseout', function (d) {
                d3.select(this)
                    .attr("stroke-width", 0)
            })
            .on('click', function (d) {
                setPlayer(null);
                nextPage("down");
            });
    }

    function nextPage(direction) {
        if (direction === "down")
            filters.page += 1;

        if (direction === "up")
            filters.page -= 1;

        renderPlayerPage();
    }


    function updateScatterplot() {

        const t = d3.transition()
            .duration(500);

        function getChartData() {

            // Change x and y based on selected 
            return playerData.map(function (d) {
                return {
                    player: d.key,
                    color: d.color,
                    xVal: d.values[0].value[filters.xMeasure.code],
                    yVal: d.values[0].value[filters.yMeasure.code],
                };
            });
        }

        function scatterplotMeasuresLabels() {

            // Update label in the left corner of the chart - measures
            const text = filters.yMeasure.name + " vs " + filters.xMeasure.name;
            const label = scatterplotSvg.select(".scatterplotMeasuresLabel");
            if (!label.empty()) {
                label.text(text);
            } else {
                scatterplotSvg.append("text")
                    .attr("x", 30)
                    .attr("y", 138)
                    .text(text)
                    .attr("font-family", "burbank")
                    .attr("font-size", "3.0em")
                    .attr("fill", "black")
                    .attr("pointer-events", "none")
                    .classed("scatterplotMeasuresLabel", true)
            }

            // Update label in the right corner of the chart - filters
            let filtersText = "";
            // Similar to something in main.js 
            if (filters.player != "") {
                filtersText = filters.player;
            } else {
                let filterParts = [];

                if (filters.team != "")
                    filterParts.push(filters.team);

                if (filters.regions.length != 0)
                    filterParts.push(filters.regions.join(", "));

                if (filters.soloOrDuo != "")
                    filterParts.push(filters.soloOrDuo);
                else
                    if (filters.week != "")
                        filterParts.push(filters.week);

                if (filters.search != "")
                    filterParts.push('"' + filters.search + '"');

                filtersText = filterParts.join(" / ");
            }
            console.log(filtersText);

            const filtersLabel = scatterplotSvg.select(".scatterplotFiltersLabel");
            const xPos = 916 - (filtersText.length * 14.1);
            if (!filtersLabel.empty()) {
                filtersLabel.text(filtersText)
                filtersLabel.attr("x", xPos);
            } else {
                scatterplotSvg.append("text")
                    .attr("x", xPos)
                    .attr("y", 125)
                    .text(filtersText)
                    .attr("font-family", "sans-serif")
                    .attr("font-size", "1.6em")
                    .attr("fill", "black")
                    .attr("pointer-events", "none")
                    .classed("scatterplotFiltersLabel", true)
            }

            // X axis label
            const xLabel = scatterplotSvg.select(".scatterplotXAxisLabel");
            if (xLabel.empty()) {
                scatterplotSvg.append("text")
                    .attr("x", 430)
                    .attr("y", 788)
                    .text(filters.xMeasure.name)
                    .attr("pointer-events", "none")
                    .classed("scatterplotXAxisLabel", true);
            } else {
                xLabel.text(filters.xMeasure.name);
            }

            // Y axis label
            const yLabel = scatterplotSvg.select(".scatterplotYAxisLabel");
            if (yLabel.empty()) {
                scatterplotSvg.append("text")
                    .attr("x", 0)
                    .attr("y", 0)
                    .text(filters.yMeasure.name)
                    .attr("pointer-events", "none")
                    .classed("scatterplotYAxisLabel", true)
                    .attr("transform", "translate(34, 490) rotate(-90)");
            } else {
                yLabel.text(filters.yMeasure.name);
            }
        }

        function updateScalesAndAxes(data, t) {

            function setAxisFormats() {
                xAxis.tickFormat(columns.filter(d => d.code == filters.xMeasure.code)[0].axisFormat);
                yAxis.tickFormat(columns.filter(d => d.code == filters.yMeasure.code)[0].axisFormat);
            }

            // First time in, create scales and axes
            if (xAxis == null) {
                xScale = d3.scaleLinear()
                    .domain([0, d3.max(data, d => d.xVal)])
                    .range([72, 930]);

                yScale = d3.scaleLinear()
                    .domain(d3.extent(data, d => d.yVal))
                    .range([720, 140]);

                xAxis = d3.axisBottom(xScale);
                scatterplotBox.append("g")
                    .classed("x axis", true)
                    .attr("transform", "translate(0, 740)")
                    .call(xAxis);

                yAxis = d3.axisLeft(yScale);
                setAxisFormats();
                svg.append("g")
                    .classed("y axis", true)
                    .attr("transform", "translate(72, 20)")
                    .call(yAxis);

                // Scales and axes already there; update domain on scale and redraw axes        
            } else {
                xScale.domain(d3.extent(data, d => d.xVal))
                yScale.domain(d3.extent(data, d => d.yVal))

                setAxisFormats();
                svg.select(".x")
                    .transition(t)
                    .call(xAxis);
                svg.select(".y")
                    .transition(t)
                    .call(yAxis);
            }
        }

        scatterplotMeasuresLabels();

        const data = getChartData();
        updateScalesAndAxes(data, t);

        var circles = svg.selectAll(".scatter")
            .data(data, function (d) { return d.player; });

        const radius = 9;
        const bigRadius = 20;

        circles
            .transition(t)
            .attr("r", radius);

        // If there is a team filter, get a list of players on the team
        let members = [];
        if (filters.team != "")
            members = teamMembers.filter(d => d.team == filters.team)[0].players;

        // Enter    
        circles
            .enter()
            .append("circle")
            .attr("cx", d => xScale(d.xVal))
            .attr("cy", d => yScale(d.yVal) + 16)
            .attr("fill", d => d.color)
            .attr("stroke", "black")
            .attr("stroke-width", 1)
            .attr("r", 0)
            .on('mouseover', function (d) {

                let left = d3.event.pageX - 510;
                if (d3.event.pageX > 1040)
                    left = d3.event.pageX - 755;

                const top = d3.event.pageY - 120;
                const height = 80;

                svg.append("rect")
                    .attr("x", left - 12)
                    .attr("y", top)

                    .attr("width", 206)
                    .attr("height", height)
                    .attr("fill", "white")
                    .attr("stroke", "black")
                    .attr("stroke", d.color)
                    .attr("stroke-width", 8)
                    .attr("rx", cornerRadius)
                    .attr("ry", cornerRadius)
                    .attr("font-size", "1.4em")
                    .classed("tooltip", true);

                svg.append("text")
                    .attr("x", left)
                    .attr("y", d3.event.pageY - 94)
                    .attr("font-size", "1.7em")
                    .text(d.player)
                    .classed("tooltip", true);

                svg.append("text")
                    .attr("x", left)
                    .attr("y", d3.event.pageY - 72)
                    .attr("font-size", "1.2em")
                    .text(filters.yMeasure.name + " " + filters.yMeasure.axisFormat(d.yVal))
                    .classed("tooltip", true);

                svg.append("text")
                    .attr("x", left)
                    .attr("y", d3.event.pageY - 52)
                    .attr("font-size", "1.2em")
                    .text(filters.xMeasure.name + " " + filters.xMeasure.axisFormat(d.xVal))
                    .classed("tooltip", true);

                d3.select(this)
                    .attr("stroke-width", 4)
            })
            .on('mouseout', function (d) {
                d3.select(this).attr("stroke-width", 1)
                d3.selectAll(".tooltip").remove();
            })
            .classed("scatter", true)
            .transition(t)
            .attr("r", radius)

        // Update    
        circles
            .transition(t)
            //.duration(3000)
            .attr("cy", d => yScale(d.yVal) + 16)
            .attr("cx", d => xScale(d.xVal))
            .style("fill-opacity", 1)
            .attr("r", d => (members.filter(mem => mem == d.player).length > 0) ? bigRadius : radius)
            .attr("stroke-width", d => (members.filter(mem => mem == d.player).length > 0) ? 5 : 1);

        // Exit    
        circles.exit()
            .attr("class", "exit")
            .transition(t)
            .attr("r", 0)
            .attr("stroke-width", 0)
            .remove();
    }


    // Show or hides scaterplot or table elements based on showingChart
    function toggleTableAndScatterplot() {

        function setMeasures() {
            // Draw column header outlines
            const xHeader = columns.filter(x => x.code === filters.xMeasure.code)[0].elm;
            xHeader
                .transition()
                .duration(100)
                .style("stroke-width", thickBorder);

            const yHeader = columns.filter(x => x.code === filters.yMeasure.code)[0].elm;
            yHeader
                .transition()
                .duration(100)
                .style("stroke-width", thickBorder);
        }

        showingScatterplot = !showingScatterplot;

        // GOING TO SHOW THE TABLE
        if (!showingScatterplot) {
            cursor.attr("stroke-width", thickBorder)

            let circles = svg.selectAll(".scatter")
            circles
                .attr("r", 0)

            scatterplotRect
                .transition()
                .duration(250)
                .style("opacity", 0);

            scatterplotButton.attr("stroke-width", 1)

            d3.select(".y").attr("stroke-opacity", 0)
            d3.select(".x").attr("stroke-opacity", 0)

            // TO DO - Border on Sort, no border on xMeasure and yMeasure
            columns.forEach(function (d) {
                d.elm
                    .transition()
                    .style("stroke-width", 0);
            })

            renderPlayerPage();
            return;
        }

        // GOING TO SHOW THE SCATTERPLOT

        // Hide table rows and things on top

        // Hide each row 
        for (let row = 0; row < rowCount; row++) {
            svg.select(".row" + row)
                .attr("fill", "none")
                .attr("stroke-width", 0);

            // Hide qualification circles from hidden rows     
            svg.select(".s" + row)
                .style("fill-opacity", 0);
            svg.select(".d" + row)
                .style("fill-opacity", 0);

            svg.select(".s" + "week" + row)
                .transition()
                .text("");
        }

        // Not awesome!    
        svg.selectAll("text")
            .each(function (d) {
                if ((d != "w") && (d3.select(this).style("fill") != "currentColor"))
                    d3.select(this).remove();
            });

        // Great - put back text we just deleted  
        columnHeaderText();
        scatterplotButtonText();

        // Make scatter plot visible
        scatterplotRect
            .transition()
            .duration(450)
            .style("opacity", 1);

        d3.select(".y").attr("stroke-opacity", 1)
        d3.select(".x").attr("stroke-opacity", 1)

        setMeasures();

        // Hide table cursor
        columns.forEach(function (d) {
            if (((d.code != filters.xMeasure.code) && (d.code != filters.yMeasure.code)) && (d.code == filters.sort))
                d.elm
                    .transition()
                    .style("stroke-width", 0);
        })
        cursor.attr("stroke-width", 0)

        updateScatterplot();
    }


    // Only works on start up - just selects first, does not unselect others!
    function drawColumnBorder(sort, strokeWidth) {
        if (!sort)
            throw "You must sort by something";

        d3.selectAll('svg')
            .selectAll('rect')
            .each(function (d) {
                if (d) {
                    if (d.code === sort)
                        d3.select(this)
                            .transition()
                            .duration(100)
                            .attr("stroke-width", strokeWidth);
                }
            });
    }

    // Draw rects for player rows. These stay, but the text on top of them changes whenever the query changes
    function drawRows() {
        const gap = 7;
        rows.forEach(function (row) {
            const player = row;

            svg.append("rect")
                .attr("data", player.num)
                .attr("x", 4)
                .attr("y", top + (row.num * rowHeight))
                .attr("width", svgWidth - 4)
                .attr("height", rowHeight - gap)
                .attr("fill", "none")
                .attr("class", "row" + row.num)
                .attr("visible", "hidden")
                .attr("stroke", "black")
                .attr("stroke-width", 0)
                .attr("rx", cornerRadius)
                .attr("ry", cornerRadius)
                .on('mouseover', function (d) {
                    const node = d3.select(this);
                    const player = playerRows[node.attr("data")].key;
                    if (filters.player === player)
                        return;

                    node.attr("stroke-width", "3");
                })
                .on('mouseout', function (d) {
                    const node = d3.select(this);
                    const player = playerRows[node.attr("data")].key;

                    // Don't remove filter is this is the selected player
                    if (filters.player === player)
                        return;

                    node.attr("stroke-width", "0");
                })
                .on('click', function (d) {
                    setPlayer(this);
                })

            // Make this after the the player rects but before the circles, so circles are on top
            if (row.num === 0)
                playerCursor = svg.append("rect")
                    .attr("x", 4)
                    .attr("y", headerPos.top + 4)
                    .attr("width", svgWidth - 4)
                    .attr("height", rowHeight - gap)
                    .attr("fill", "none")
                    .attr("stroke", "black")
                    .attr("stroke-width", 0)
                    .attr("pointer-events", "none")
                    .attr("rx", cornerRadius)
                    .attr("ry", cornerRadius);

            svg.append("circle")
                .attr("cx", 21)
                .attr("cy", top + (row.num * rowHeight) + 14)
                .attr("r", 12)
                .attr("fill", "#FFAC08")
                .attr("fill-opacity", 0.0)
                .classed("s" + row.num, true);

            svg.append("text")
                .attr("x", 17)
                .attr("y", top + (row.num * rowHeight) + 20)
                .text("9")
                .attr('fill', "black")
                .attr("font-size", "1.2em")
                .attr("pointer-events", "none")
                .attr("font-weight", 600)
                .classed("sweek" + row.num, true)
                .data("w");

            const g = svg.append("g")
                .style("fill-opacity", 0.0)
                .attr("pointer-events", "none")
                .classed("d" + row.num, true);

            g.append("circle")
                .attr("cx", 44)
                .attr("cy", top + (row.num * rowHeight) + 10)
                .attr("r", 9)
                .attr("fill", "#FFAC08")

            g.append("circle")
                .attr("cx", 54)
                .attr("cy", top + (row.num * rowHeight) + 19)
                .attr("r", 9)
                .attr("fill", "#FFAC08")

            g.append("text")
                .attr("x", 44)
                .attr("y", top + (row.num * rowHeight) + 20)
                .text("1")
                .attr('fill', "black")
                .attr("font-size", "1.2em")
                .attr("pointer-events", "none")
                .attr("font-weight", 600)
                .classed("dweek" + row.num, true)
                .data("w");
        });
    }

    function movePlayerCursor(hide) {
        if (hide) {
            playerCursorVisible = false;
            playerCursor
                .transition()
                .duration(200)
                .attr("stroke-width", 0)
            return;
        }

        // Bet there is a better way to do this...
        const x = selectedRect._groups[0][0].x.baseVal.value;
        const y = selectedRect._groups[0][0].y.baseVal.value;
        if (!playerCursorVisible) {
            playerCursor
                .attr("x", x)
                .attr("y", y);

            playerCursor
                .transition()
                .duration(100)
                .attr("stroke-width", thickBorder);
        } else {
            playerCursor
                .attr("stroke-width", thickBorder)
                .transition()
                .ease(d3.easeBack)
                .duration(300)
                .attr("x", x)
                .attr("y", y)
        }
        playerCursorVisible = true;
    }

    // Either the player node they clicked or null (they set player to null be because they reset the region, week, search or sort ) 
    function setPlayer(node) {

        // 0) Clear the filter - called from elsewhere, e.g. a group filter was set
        if (node === null) {
            filters.player = "";
            if (selectedRect != null) {
                selectedRect.attr("stroke", 0);
                selectedRect = null;
            }
            showPlayerOnWeekChart("");

            playerCursorVisible = false;
            movePlayerCursor(true);
            return;
        }

        // Below are cases where they clicked a player row 
        const clickedNode = d3.select(node);
        const clickedPlayer = playerRows[clickedNode.attr("data")].key;

        // 1) None were clicked before
        if (filters.player === "") {
            filters.player = clickedPlayer;

            clickedNode.attr("stroke-width", thickBorder - 2);
            showPlayerOnWeekChart(clickedPlayer);
            selectedRect = clickedNode;

            //showPlayerProfile(clickedPlayer);

            playerCursorVisible = false;
            movePlayerCursor(false);
            updateCounts();
            return;
        }

        // 2 One is already selected, so unselect it and select this
        if (node !== selectedRect.node()) {
            selectedRect.attr("stroke-width", 0);
            selectedRect = clickedNode;

            filters.player = clickedPlayer;
            clickedNode.attr("stroke-width", thickBorder - 2);
            showPlayerOnWeekChart(clickedPlayer);

            //showPlayerProfile(clickedPlayer);

            movePlayerCursor(false);
            updateCounts();
            return;
        }

        // 3 This was selected, so unselect it - all will be selected
        clickedNode.attr("stroke-width", 0);
        filters.player = "";
        selectedRect = null;

        movePlayerCursor(true);
        updateCounts();
        showPlayerOnWeekChart("");
    }


    // Draws current players on top of already-existing rectangles
    function renderRows() {
        // This should always be reset here - right?
        filters.page = 0;

        // Refresh playerData (crossfilter)
        updatePlayerData();
        // Render the slice of playerData based on filters.page 
        renderPlayerPage();
    }

    // The data that gets rendered in the table. It gets updated whenever anything changes. But paging does not update it - it just grabs a slice
    function updatePlayerData() {

        function filterPlayersFast(data, dimVals) {
            let names = dimVals.map(x => x.player);
            var index = names.reduce(function (a, b) { a[b] = 1; return a; }, {});
            let filteredData = data.filter(function (item) {
                item.color = playerColors[item.key];
                return index[item.key] === 1;
            });
            return filteredData;
        }

        const sortColumn = filters.sort;
        const sortOrder = (filters.sort !== "rank") ? d3.descending : d3.ascending;

        let values = d3.nest()
            .key(function (d) { return d.key; })
            .sortKeys(sortOrder)
            .entries(_chart.dimension().top(Infinity));

        // Remove non World Cup, if neccessary
        if (filters.worldCupOnly)
            values = values.filter(d => qualifierNames[d.key] != undefined);

        // Set player data, which is what gets rendered (or a slice of it)
        playerData = filterPlayersFast(values, playerDim.top(Infinity));
        playerData.sort(function (a, b) {
            return sortOrder(a.values[0].value[sortColumn], b.values[0].value[sortColumn]);
        });

        filters.playerCount = playerData.length;
    }


    // Render the slice of playerData generated in updatePlayerData() based on filters.page 
    function renderPlayerPage() {

        if (showingScatterplot) {
            //svg.selectAll(".scatter")
            //    .remove();

            updateScatterplot();
            return;
        }

        function cellText(row, i, rowNum) {
            if (i == 0)
                return row.key;

            const value = row.values[0].value[columns[i].code];
            // Show the number, as long as it isn't the first one - i.e rank/count    
            if (i != 1)
                return columns[i].format(value);

            // First number column is weird - if week is selected, it should be the ranking for that week. Otherwise, it should just be the row number    
            return (filters.week === "") ? first + rowNum + 1 : value;
        }

        // Make a list of 20. Zero based page, zero based slices
        const pageSize = 20;
        const first = pageSize * filters.page;
        const last = (pageSize * (filters.page + 1));
        const toShow = playerData.slice(first, last);

        playerRows = [];
        for (let i = 0; i < rowCount; i++)
            playerRows.push(toShow[i]);

        // Not awesome!    
        let x = svg.selectAll("text")
            .each(function (d) {
                if (d != "w")
                    d3.select(this).remove();
            });

        columnHeaderText();
        scatterplotButtonText();

        let rowNum = 0;
        playerRows.forEach(function (row) {
            // Only one player, so simulate a click on him
            if (toShow.length === 1 && rowNum == 0) {
                svg.select(".row0")
                    .each(function (d) {
                        setPlayer(this);
                    });
            }

            // If there is no row (filters returned fewer queries than rows) make the row transarent
            if (!row) {
                svg.select(".row" + rowNum)
                    .attr("fill", "none")
                    .attr("stroke-width", 0);

                // Also hide qualification circles from hidden rows     
                svg.select(".s" + rowNum)
                    .style("fill-opacity", 0);
                svg.select(".d" + rowNum)
                    .style("fill-opacity", 0);

                svg.select(".s" + "week" + rowNum)
                    .transition()
                    .text("");

                // Don't do anything else for lower rows - just get out     
                rowNum++;
                return;
            }

            // Draw the text for the row, including the player name
            svg.selectAll(".row").data(columns).enter().append("text")
                .attr("x", function (d, i) {
                    if (i === 0)
                        return 68; // width for player name 

                    const chars = (cellText(row, i, rowNum).toString()).length;
                    const charWidth = 10;

                    let moveRight = (6 - chars) * charWidth;

                    // Center the first column a little more
                    if (i === 1)
                        moveRight -= 18;

                    return playerColWidth + moveRight + headerPos.gap + 10 + (headerPos.width * (i - 1))
                })
                .attr("y", top + (rowNum * rowHeight) + 21)
                .text(function (d, i) {
                    return cellText(row, i, rowNum);
                })
                .attr('fill', "black")

                .attr("font-size", d => (d.code === filters.sort) ? "1.7em" : "1.3em")
                .attr("pointer-events", "none")
                .attr("font-weight", d => (d.code === filters.sort) ? 1000 : 260);

            const rowSelection = svg.select(".row" + rowNum);

            // Ugh - override whatever color the person has if a region is selected
            //let fillColor = colors[row.color];
            let fillColor = row.color;
            if (filters.regions.length === 1) {
                if (filters.region === "NA East") fillColor = '#56af5a';
                if (filters.region === "NA West") fillColor = '#ad76c1';
                if (filters.region === "Europe") fillColor = '#4C51F7';
                if (filters.region === "Oceania") fillColor = '#e25856';
                if (filters.region === "Brazil") fillColor = '#3E93BC';
                if (filters.region === "Asia") fillColor = '#987654';
            }

            rowSelection
                .transition()
                .attr("fill", fillColor);

            showHideCircles(soloQualifications, "s", row.key, rowNum);
            showHideCircles(duoQualifications, "d", row.key, rowNum);

            rowNum++;
        });

        setRowRankColumn();
        showArrows(pageSize, first, last)
        updateCounts();
    }


    // Show/hide circles
    function showHideCircles(list, code, player, rowNum) {
        const qual = list.find(d => (d.player === player));
        const qualWeek = qual ? qual.week : 0;

        // Show/hide circles    
        svg.select("." + code + rowNum)
            .transition()
            .style("fill-opacity", (qualWeek == 0) ? 0 : 1);

        // Show/hide week number
        const text = svg.select("." + code + "week" + rowNum)
        text
            .transition()
            .text((qualWeek == 0) ? "" : qualWeek);

        // Ugh - 10 is wider, so center it    
        if (code === "d")
            text
                .transition()
                .attr("x", (qualWeek == "10") ? 40 : 45)
    }


    // Hide or show arrows base on where the page is
    function showArrows(pageSize, first, last) {

        function onOff(arrow, on) {
            arrow.style("fill-opacity", on ? 1 : 0);
            arrow.attr("pointer-events", on ? "auto" : "none");
        }

        // Less than a full screen - so no paging
        if (playerData.length < pageSize) {
            onOff(upArrowPolygon, false);
            onOff(downArrowPolygon, false);
        }

        // On first page, so no going back
        if (filters.page === 0)
            onOff(upArrowPolygon, false);

        // Not on first page, so you can go up    
        if (filters.page > 0)
            onOff(upArrowPolygon, true);

        // There are more pages, so you can go down    
        if (last < playerData.length)
            onOff(downArrowPolygon, true);

        // There are no more pages, so you can't go down    
        if (last >= playerData.length)
            onOff(downArrowPolygon, false);
    }

    function setRowRankColumn() {
        if (filters.week === "") {
            numOrRankText
                .text("#")
                .attr("x", playerColWidth + headerPos.gap + columns[1].x + 12)
                .attr("y", 59)
                .attr("font-size", "2.6em");

            numOrRankRect
                .attr("fill", "none")
                .attr("pointer-events", "none")
                .attr("stroke-width", 0);

            // Need to shift move sord away from rank when it doesn't make any sense.    
        } else {
            numOrRankText.text("Rank");
            numOrRankRect
                .attr("fill", "lightblue")
                .attr("pointer-events", "auto")
            //.attr("stroke-width", thickBorder)
            //.attr("stroke-width", (numOrRankRect && filters.week) ? thickBorder : 0)                
        }
    }


    // DC related stuff
    _chart._doRender = function () {
        renderRows();
        return _chart;
    };

    _chart._doRedraw = function () {
        return _chart._doRender();
    };

    clearPlayer = setPlayer;
    playerChart_renderPlayerPage = renderPlayerPage;

    return _chart;
}
