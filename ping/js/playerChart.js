// @language_out ecmascript5

import { colors } from "./shared.js";

import { cornerRadius, filters, playerDim, playerInfos, playerColors, soloQualifications, duoQualifications, qualifierNames, updateCounts, teamMembers } from "./main.js";
import { checkBox } from "./checkBox.js";
import { profile, profileOpen } from "./profile.js";
import { playerCirclePackChart } from "./playerCirclePackChart.js";

export let clearPlayer
export let PlayerTableWidth;
export let playerData;

export let showingCirclePack = false;

export let playerChart_renderPlayerPage;


export function playerChart(id) {

    const showCirclePackButton = true;

    const noFormat = function (d) { return d; }
    const commaFormat = d3.format(",");
    const pctFormat = d3.format(",.1%");
    const pctAxisFormat = d3.format(",.0%");
    const moneyFormat = function (d) { return "$" + d3.format(",")(d); };
    const moneyKFormat = d3.format(".2s");
    const tenthsFormat = d3.format(".1f");

    const columns = [
        { name: "Players", code: "player", x: 10, format: noFormat, axisFormat: noFormat },
        { name: "Rank", code: "rank", x: 16, format: noFormat, axisFormat: noFormat },
        //{ name: "Power Rank", code: "powerPoints", x: 0, format: commaFormat, axisFormat: noFormat },
        { name: "Payout", code: "payout", x: 9, format: commaFormat, format: commaFormat, axisFormat: moneyKFormat },
        { name: "Points", code: "points", x: 13, format: noFormat, axisFormat: noFormat },
        { name: "Wins", code: "wins", x: 17, format: noFormat, axisFormat: noFormat },
        { name: "CS Avg #", code: "earnedQualifications", x: 0, format: tenthsFormat, axisFormat: noFormat }, 
        { name: "Elims", code: "elims", x: 15, format: noFormat, axisFormat: noFormat },
        { name: "Elim %", code: "elimPercentage", x: 16, format: pctFormat, axisFormat: pctAxisFormat },
        { name: "Placement", code: "placementPoints", x: 0, format: noFormat, axisFormat: noFormat },
        { name: "Placement %", code: "placementPercentage", x: 0, format: pctFormat, axisFormat: pctAxisFormat }
    ];

    const headerPos = { left: 150, top: 0, height: 69, width: 80, gap: 5 };

    const playerColWidth = 300;
    PlayerTableWidth = playerColWidth + (headerPos.width * (columns.length - 1) + 4);

    const _chart = dc.baseMixin({});

    const top = headerPos.height + 14;
    const rowHeight = 36;
    const rowCount = 20;

    const thinBorder = 2;
    const thickBorder = 5;

    let numOrRankRect;
    let numOrRankText;

    let upArrowPolygon;
    let downArrowPolygon;

    let circlePackButton;

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
        .attr("height", 1000);

    let championSeriesAveragers = playerInfos.filter(d => d.championSeriesAvg > 0);    

    drawHeaders(svg);
    drawRows(svg);

    const circlePackBox = svg.append("g");
    const circlePackSvg = circlePackBox.append("svg")
        .attr("width", svgWidth + 4)
        .attr("height", 800)
        .attr("transform", "translate(0,200)")

    const corner = 6;
    const circlePackRect = circlePackSvg.append("rect")
        .attr("x", 3)
        .attr("y", 84)
        .attr("width", svgWidth - 6)
        .attr("height", 713)
        .attr("fill", "#F0F8FF")
        .attr("stroke", "black")
        .attr("stroke-width", 9)
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)
        .attr("opacity", "0")
        .attr("pointer-events", "none");


    function circlePackButtonText() {

        function addText(x, y, text) {
            svg.append("text")
                .attr("x", x)
                .attr("y", y)
                .attr("fill", "black")
                .attr("stroke", "black")
                .text(text)
                .attr("font-size", "1.2em")
                .attr("pointer-events", "none")
                .attr("font-weight", 300)
                .classed("circlePackButton-" + text, true)
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
                if (showingCirclePack)
                    circlePackHeaderClick(d, this);
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

        if (showCirclePackButton)
            makeCirclePackButton();

        drawColumnBorder("powerPoints", thickBorder);

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

    // Button on top left to switch between table and circlePack
    function makeCirclePackButton() {

        // Circle pack doesn't work, but turn on this button to try it.
        return;

        circlePackButton = svg.append("rect")
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
                toggleTableAndCirclePack();
            });

        circlePackButtonText();
    }


    function moveCursor(rect) {
        const x = rect.x.baseVal.value;
        const y = rect.y.baseVal.value;

        cursor
            .transition()
            .duration(600)
            .attr("x", x)
            .attr("y", y);
    }


    function columnHeaderText() {

        function addText(i) {

            const text = columns[i].name;
            const fontSize = (i === 0) ? "2.2em" : "1.3em";
            const x = (i === 0) ? columns[i].x : playerColWidth + headerPos.gap + (headerPos.width * (i - 1)) + columns[i].x;

            const smallFontSize = "1.1em";
            const mediumFontSize = "1.2em";

            // Power Rank
            if (text === "Power Rank") {
                svg.append("text")
                    .attr("x", x + 10)
                    .attr("y", 34)
                    .text("Power")
                    .classed("column-button", true);

                svg.append("text")
                    .attr("x", x + 15)
                    .attr("y", 56)
                    .text("Rank")
                    .classed("column-button", true);
                return;
            }

            // Earned Quals
            if (text === "CS Avg #") {

                svg.append("text")
                    .attr("x", x + 6)
                    .attr("y", 26)
                    .text("Champ.")
                    .classed("column-button", true);
                svg.append("text")
                    .attr("x", x + 12)
                    .attr("y", 46)
                    .text("Series")
                    .classed("column-button", true);

                svg.append("text")
                    .attr("x", x + 16)
                    .attr("y", 64)
                    .text("Avg #")
                    .classed("column-button", true);
                return;
            }

            // Elim Points
            if (text === "Elims") {
                svg.append("text")
                    .attr("x", x + 6)
                    .attr("y", 34)
                    .text("Elim")
                    .classed("column-button", true);

                svg.append("text")
                    .attr("x", x)
                    .attr("y", 56)
                    .text("Points")
                    .classed("column-button", true);
                return;
            }

            // Elim %
            if (text === "Elim %") {
                svg.append("text")
                    .attr("x", x + 3)
                    .attr("y", 35)
                    .text("Elim")
                    .classed("column-button", true);

                svg.append("text")
                    .attr("x", x + 10)
                    .attr("y", 57)
                    .text("%")
                    .classed("column-button", true);
                return;
            }

            // Placement Points
            if (text === "Placement") {
                svg.append("text")
                    .attr("x", x + 16)
                    .attr("y", 34)
                    .text("Place")
                    .classed("column-button", true);

                svg.append("text")
                    .attr("x", x + 11)
                    .attr("y", 55)
                    .text("Points")
                    .classed("column-button", true);
                return;
            }

            // Placement %
            if (text === "Placement %") {
                svg.append("text")
                    .attr("x", x + 16)
                    .attr("y", 34)
                    .text("Place")
                    .classed("column-button", true);

                svg.append("text")
                    .attr("x", x + 25)
                    .attr("y", 57)
                    .text("%")
                    .classed("column-button", true);
                return;
            }

            // Default case
            const y = (i === 0) ? 55 : 44; // Player
            const otherSize = (i == 0) ? "2.3rem" : smallFontSize;
            const node = svg.append("text")
                .attr("x", x)
                .attr("y", y)
                .text(text)
                .attr("font-size", otherSize)
                .style("font-weight", 600)
                .style("pointer-events", "none");

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

        //drawWorldCupOnly();
    }

    function drawWorldCupOnly() {
        svg.append("text")
            .attr("x", 11)
            .attr("y", 68)
            .text("World Cup Only")
            .classed("checkbox-label", true);


        worldCupOnlyCheckBox = new checkBox("X");
        worldCupOnlyCheckBox
            .size(25)
            .x(150)
            .y(50)
            .rx(cornerRadius)
            .ry(cornerRadius)
            .markStrokeWidth(4)
            .boxStrokeWidth(1)
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
        const width = 40;
        const height = headerPos.height / 2;

        upArrowPolygon = svg.append("polygon")
            .attr("points", (playerColWidth - width) + "," + (height - 2) + " " + playerColWidth + "," + (height - 2) + " " + (playerColWidth - (width / 2)) + "," + 4)
            .style("fill", "darkgrey")
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
            .style("fill", "darkgrey")
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


    function updateCirclePack() {

        const t = d3.transition()
            .duration(500);

        function circlePackMeasuresLabels() {

            // Update label in the left corner of the chart - measures
            const text = filters.yMeasure.name + " vs " + filters.xMeasure.name;
            const label = circlePackSvg.select(".circlePackMeasuresLabel");
            if (!label.empty()) {
                label.text(text);
            } else {
                circlePackSvg.append("text")
                    .attr("x", 40)
                    //.attr("y", 157)
                    .attr("y", 200)
                    .text(text)
                    .attr("font-family", "burbank")
                    //.attr("font-size", "4.4em")
                    .attr("font-size", "5.0em")
                    .attr("fill", "lightgrey")
                    .attr("pointer-events", "none")
                    .classed("circlePackMeasuresLabel", true)
            }

            // Big diagonal label for week/solo/duo 
            let weekText = "";
            if (filters.soloOrDuo != "")
                weekText = filters.soloOrDuo;
            else
                if (filters.week != "")
                    weekText = filters.week;

            // Solos and Duos are shorter the "Week x", so shift them        
            const solosOrDuos = (weekText == "Solos" || weekText == "Duos");
            const xVal = solosOrDuos ? 100 : 10;
            const yVal = solosOrDuos ? 10 : 10;
            const fontSize = solosOrDuos ? "22em" : "18em";

            const weekLabel = circlePackSvg.select(".weekLabel");
            if (!weekLabel.empty()) {
                weekLabel
                    .text(weekText)
                    .transition()
                    .duration(800)
                    .attr("font-size", fontSize)
                    .attr("x", xVal)
                    .attr("y", yVal);
            } else {
                circlePackSvg.append("text")
                    .text(weekText)
                    .attr("font-family", "burbank")
                    .attr("font-size", fontSize)
                    .attr("fill", "lightgrey")
                    .attr("pointer-events", "none")
                    .attr("transform", "translate(160, 710) rotate(-27)")
                    .classed("weekLabel", true)
                    .attr("x", xVal)
                    .attr("y", yVal)
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

                if (filters.search != "")
                    filterParts.push('"' + filters.search + '"');

                filtersText = filterParts.join(" / ");
            }

            const filtersLabel = circlePackSvg.select(".circlePackFiltersLabel");
            const xPos = 920 - (filtersText.length * 22.7);
            if (!filtersLabel.empty()) {
                filtersLabel.text(filtersText)
                filtersLabel.attr("x", xPos);
            } else {
                circlePackSvg.append("text")
                    .attr("x", xPos)
                    .attr("y", 128)
                    .text(filtersText)
                    .attr("font-family", "sans-serif")
                    .attr("font-size", "2.4em")
                    .attr("fill", "darkgrey")
                    .attr("pointer-events", "none")
                    .classed("circlePackFiltersLabel", true)
            }

            // X axis label
            const xLabel = circlePackSvg.select(".circlePackXAxisLabel");
            if (xLabel.empty()) {
                circlePackSvg.append("text")
                    .attr("x", 430)
                    .attr("y", 788)
                    .text(filters.xMeasure.name)
                    .attr("pointer-events", "none")
                    .classed("circlePackXAxisLabel", true);
            } else {
                xLabel.text(filters.xMeasure.name);
            }

            // Y axis label
            const yLabel = circlePackSvg.select(".circlePackYAxisLabel");
            if (yLabel.empty()) {
                circlePackSvg.append("text")
                    .attr("x", 0)
                    .attr("y", 0)
                    .text(filters.yMeasure.name)
                    .attr("pointer-events", "none")
                    .classed("circlePackYAxisLabel", true)
                    .attr("transform", "translate(28, 490) rotate(-90)");
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
                    .range([720, 180]);

                xAxis = d3.axisBottom(xScale);
                circlePackBox.append("g")
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

        function updatePlayerAnnotations() {

            // Remove old player annotations
            d3.selectAll(".player-annotation")
                .transition()
                .duration(250)
                .style("opacity", 0)
                .remove();

            // Add player annotations 
            playersToAnnotate.forEach(function (player) {
                console.log(player);
                svg.append("text")
                    .style("opacity", 0)
                    //.attr("x", () => xScale(player.xVal) + 38)

                    .attr("x", function () {
                        let x = xScale(player.xVal) + 38;
                        if (x > 800)
                            x = x -= 90 + (player.player.length * 12);
                        return x;
                    })
                    .attr("y", () => yScale(player.yVal) + 22)
                    .attr("font-size", "1.8em")
                    .attr("font-weight", "600")
                    .text(player.player)
                    .classed("player-annotation", true)
                    .transition()
                    .duration(500)
                    .style("opacity", 1.0);
            });

            // Allow drag & drop for annotations
            const dragHandler = d3.drag()
                .on("drag", function () {
                    d3.select(this)
                        .attr("x", d3.event.x)
                        .attr("y", d3.event.y);
                });

            dragHandler(svg.selectAll(".player-annotation"));
        }

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

        circlePackMeasuresLabels();

        const data = getChartData();
        updateScalesAndAxes(data, t);

        var circles = svg.selectAll(".scatter")
            .data(data, function (d) { return d.player; });

        const radius = 9;
        const bigRadius = 30;

        circles
            .transition(t)
            .attr("r", radius);

        // If there is a team filter, get a list of players on the team
        let members = [];
        if (filters.team != "")
            members = teamMembers.filter(d => d.team == filters.team)[0].players;

        let playersToAnnotate = [];


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

                // Make tooltip for player
                const rectWidth = 120 + (5 * d.player.length) // 206
                let left = d3.event.pageX - 510;
                if (d3.event.pageX > 1040)
                    left = d3.event.pageX - 555 - rectWidth;

                const top = d3.event.pageY - 120;
                const height = 80;

                svg.append("rect")
                    .attr("x", left - 12)
                    .attr("y", top)

                    .attr("width", rectWidth)
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
            // Hide player tooltip
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
            .attr("cy", d => yScale(d.yVal) + 16)
            .attr("cx", d => xScale(d.xVal))
            .style("fill-opacity", 1)
            .attr("r", function (d) {
                if (members.filter(mem => mem == d.player).length > 0) {
                    // He's on the team, put him int the list to get annotated later
                    playersToAnnotate.push(d);
                    return bigRadius;
                } else
                    return radius;
            })
            .attr("stroke-width", d => (members.filter(mem => mem == d.player).length > 0) ? 5 : 1);

        // Exit    
        circles.exit()
            .attr("class", "exit")
            .transition(t)
            .attr("r", 0)
            .attr("stroke-width", 0)
            .remove();

        updatePlayerAnnotations();
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
                            .duration(200)
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
                .ease(d3.quad)
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
            //showPlayerOnWeekChart("");

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
            showPlayerProfile(clickedPlayer);
            selectedRect = clickedNode;

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
            showPlayerProfile(clickedPlayer);

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
        showPlayerProfile("");
    }

    function showPlayerProfile(player) {
        if (!profileOpen) {
            d3.select(".gradient")
                .transition()
                .style("background-color", "lightgrey")
            
            profile(player)
        }
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
        const sortOrder = (filters.sort !== "rank" && filters.sort !== "earnedQualifications") ? d3.descending : d3.ascending;

        let values = d3.nest()
            .key(function (d) { return d.key; })
            .sortKeys(sortOrder)
            .entries(_chart.dimension().top(Infinity));

        // Remove non World Cup, if neccessary
        if (filters.worldCupOnly)
            values = values.filter(d => qualifierNames[d.key] != undefined);

        // Set player data, which is what gets rendered (or a slice of it)
        playerData = filterPlayersFast(values, playerDim.top(Infinity));

        // Lookup Champion Series average placement
        playerData.forEach(function (d) {
            let avg = championSeriesAveragers.find(averager => averager.name === d.key)
            d.values[0].value.earnedQualifications = avg ? +avg.championSeriesAvg : +10000;
        })

        playerData.sort(function (a, b) {
            return sortOrder(a.values[0].value[sortColumn], b.values[0].value[sortColumn]);
        });

        filters.playerCount = playerData.length;
    }


    // Render the slice of playerData generated in updatePlayerData() based on filters.page 
    function renderPlayerPage() {

        if (showingCirclePack) {
            updateCirclePack();
            return;
        }

        function cellText(row, i, rowNum) {
            if (i == 0)
                return row.key;

            
            const value = row.values[0].value[columns[i].code];
            
            // Weird case = Champion Series average placement is 10000 ifthere are missing values, so return a dash for that 
            if (i ==  5)
                return columns[i].format(value) > 9999 ? "-" : columns[i].format(value);


            // Show the number, as long as it isn't the first one - i.e rank/count    
            if (i != 1)
                return columns[i].format(value);

            // First number column is weird - if week is selected, it should be the ranking for that week. Otherwise, it should just be the row number    
            return (filters.weeks.length != 1 ) ? first + rowNum + 1 : value;
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
        circlePackButtonText();

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
                    const charWidth = 8;

                    let moveRight = (6 - chars) * charWidth;

                    // Center the first column a little more
                    if (i === 1)
                        moveRight -= 18;

                    const width = playerColWidth + moveRight + headerPos.gap + 10 + (headerPos.width * (i - 1));
                    
                    // Payouts can be huge, so shift to right
                    return width + ((d.name === "Payout") ? 20 : 0);
                })
                .attr("y", top + (rowNum * rowHeight) + 21)
                .text(function (d, i) {
                    return cellText(row, i, rowNum);
                })
                .attr('fill', "black")

                .attr("font-size", d => (d.code === filters.sort) ? "1.2em" : "1.1em")
                .attr("pointer-events", "none")
                .attr("font-weight", d => (d.code === filters.sort) ? 600 : 260);

            const rowSelection = svg.select(".row" + rowNum);

            // Ugh - override whatever color the person has if a region is selected
            let fillColor = row.color;
            if (filters.regions.length === 1) {
                if (filters.regions[0] === "NA East") fillColor = colors.green;
                if (filters.regions[0] === "NA West") fillColor = colors.orange;
                if (filters.regions[0] === "Europe") fillColor = colors.blue;
                if (filters.regions[0] === "Oceania") fillColor = colors.pink;
                if (filters.regions[0] === "Brazil") fillColor = colors.teal;
                if (filters.regions[0] === "Asia") fillColor = colors.yellow;
                if (filters.regions[0] === "Middle East") fillColor = colors.grey;
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
        //if (filters.week === "") {
        if (filters.weeks.length != 1) {
            numOrRankText
                .text("#")
                .attr("x", playerColWidth + headerPos.gap + columns[1].x + 12)
                .attr("y", 52)
                .attr("font-size", "2.6em");

            numOrRankRect
                .attr("fill", "none")
                .attr("pointer-events", "none")
                .attr("stroke-width", 0);

        // Need to shift move sort away from rank when it doesn't make any sense.    
        } else {
            numOrRankText.text("Place");
            numOrRankRect
                .attr("fill", "lightblue")
                .attr("pointer-events", "auto")
            //.attr("stroke-width", thickBorder)
            //.attr("stroke-width", (numOrRankRect && filters.week) ? thickBorder : 0)                
        }
    }


    // Show or hides scaterplot or table elements based on showingChart
    function toggleTableAndCirclePack() {

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

        showingCirclePack = !showingCirclePack;
        //ga('set', 'page', showingCirclePack ? "/circlePack" : "/listing");
        //ga('send', 'pageview');


        // GOING TO SHOW THE TABLE
        if (!showingCirclePack) {
            cursor.attr("stroke-width", thickBorder)

            let circles = svg.selectAll(".scatter")
            circles
                .attr("r", 0)

            circlePackRect
                .transition()
                .duration(250)
                .style("opacity", 0);

            circlePackButton.attr("stroke-width", 1)

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
        circlePackButtonText();

        // Make scatter plot visible
        circlePackRect
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

        playerCirclePackChart(svg, playerData);
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
