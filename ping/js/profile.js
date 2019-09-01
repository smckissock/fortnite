import { facts, statsForPlayer, playerInfos, data } from "./main.js";
import { text, centeredText, colors } from "./shared.js";
import { events } from "./eventChart.js";


export function profile(player) {

    let svg;

    let headerG;
    let rankG;
    let trendG;
    let matchG;  

    const svgWidth = 1200;
    const svgHeight = 1200;

    const leftMargin = 160;

    const formatColor = 
        { 
            "Total": colors.grey,
            "Solos": colors.blue,
            "Duos": colors.orange,
            "Trios": colors.yellow
        }


    function enableSvgs(enabled) {
        const val = enabled ? "auto" : "none"
        d3.selectAll("svg")
            .each(function () {
                d3.select(this)
                    .attr("pointer-events", val);
            })
    }

    function hide() {
        enableSvgs(true);
        headerG.transition()
            .duration(100)
            .attr("fill-opacity", .0)
            .attr("opacity", .0)
            .on("end", () => svg.remove());
    }

    function makeSvg() {

        const headerHeight = 120;
        const rankHeight = 140;
        const trendHeight = 160;
        const matchHeight = 600

        const headerTop = 80;
        const rankTop = headerTop + headerHeight;
        const trendTop = rankTop + rankHeight;
        const matchTop = trendTop + trendHeight;

        const div = d3.select("#chart-player");
        svg = div.append("svg")
            .attr("width", svgWidth + 6)
            .attr("height", svgHeight + 6)
            .attr("transform", "translate(-250,-1327)")
            .attr("fill", "black")

        function makeG(top, height, color) {
            const g = 
                svg.append("g")
                    .attr("transform", 'translate(0,' + top + ')')
            
            g.append("rect")
                .attr("x", 0)
                .attr("y", 0)
                .attr("width", svgWidth)
                .attr("height", height + 1)
                .attr("opacity", 1.0) 
                .attr("fill", color)
            return g;    
        }    
        headerG = makeG(headerTop, headerHeight, "white");
        rankG = makeG(rankTop, rankHeight, "white");
        trendG = makeG(trendTop, trendHeight, "white");
        matchG = makeG(matchTop, matchHeight, "white"); 
    }


    function makeHeader() {

        function makeHelpButton(stats) {
            //text("World Cup Finals not included", svg, "player-stat-row", screenWidth - 730, 120);
            text("fortniteping.com", svg, "little-ping", svgWidth - 300, 117);

            headerG.append("circle")
                .attr("cx", svgWidth - 30)
                .attr("cy", 30)
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

            headerG.append("text")
                .attr("x", svgWidth - 38)
                .attr("y", 39)
                .text("X")
                .attr("font-size", "1.7em")
                .attr("fill", "black")
                .attr("pointer-events", "none");
        }

        function makePlayerInfo(stats) {
            const left = 30;

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
            headerG.append("text")
                .classed("player-summary", true)
                .attr("x", left)
                .attr("y", 130)
                .text(player)
                .attr("fill", "black")
                .attr("font-size", 0)
                .transition()
                .duration(140)
                .attr("y", 60)
                .attr("font-size", (player.length < 16) ? "3.2em" : "2.6em")
    
            // Player team, nationality & age, if any 
            text(playerInfoLabel, headerG, "player-info", left, 95);
        }

        makePlayerInfo(); 
        makeHelpButton(svg, svgWidth);
    }

    function makeRanks(stats, region) {
        text("Rank", rankG, "g-header", 30, 40);

        const rectWidth = 220;
        stats.totalPayout = stats.soloPayout + stats.duoPayout + stats.trioPayout;  
        [   {name: "Total", x: leftMargin},
            {name: "Solo", x: leftMargin + (rectWidth + 20)},
            {name: "Duo", x: leftMargin + (rectWidth + 20) * 2},
            {name: "Trio", x: leftMargin + (rectWidth + 20) * 3}  
        ].forEach(function(d) {
            const rect = rankG.append("rect")
                .attr("x", d.x)
                .attr("y", 0)
                .attr("width", rectWidth)
                .attr("height", 120)
                .attr("opacity", 1.0) 
                .attr("fill", (d.name == "Total") ? formatColor[d.name] : formatColor[d.name + "s"])  // Good Lord. Need to make it always "Solos" 

                console.log(d.name + "s");
            
            centeredText(d.name, rankG, "player-info", d.x, rectWidth, 34);
            centeredText("$" + num(stats[d.name.toLowerCase() + "Payout"]), rankG, "player-info", d.x, rectWidth, 66);
            centeredText("#" + stats[d.name.toLowerCase() + "PayoutRank"] + " " + region, rankG, "player-info", d.x, rectWidth, 100);
        });
    }

    function makeTrends(recs) {
        text("Trend", trendG, "g-header", 30, 40);

        // Un-nest the events
        let data = [];
        events.forEach(function(formatList) {
            formatList.items.forEach(function(event) {
                event.format = formatList.format;
                
                event.payout = 0;
                const matches = recs.filter(d => d.week === event.name);
                // Add the player-specific results
                if (matches.length != 0) {
                    event.payout = matches[0].payout;
                    event.data = matches[0];
                }
                data.push(event);
            })
        })

        const xScale = d3.scaleLinear()
            .domain([0, data.length - 1])
            .range([40, svgWidth - 100]);
            
        //const ySacle = d3.scalePow()
        //    .exponent(k)
        const chartHeight = 120;
        const yScale = d3.scaleLinear()
            .domain(d3.extent(data, d => d.payout))
            .range([0, chartHeight - 20])

        //for (let i=0; i < 14; i++)
        //    console.log(xScale(i));   

      
        trendG.selectAll("rect").data(data).enter().append("rect")
            .attr("x", d => xScale(d.weekNum))
            .attr("y", d => chartHeight - yScale(d.payout))
            .attr("width", 50)
            .attr("height", d => yScale(d.payout))
            .attr("fill", d => formatColor[d.format]) 
    }

    function makeMatches(recs) {

        const colWidth = 80;
        const rowHeaderWidth = 420; // 280
        
        const noFormat = function (d) { return d; }
        const commaFormat = d3.format(",");
        const pctFormat = d3.format(",.1%");
        const pctAxisFormat = d3.format(",.0%");
        const moneyFormat = function (d) { return "$" + d3.format(",")(d); };
        const moneyKFormat = d3.format(".2s");

        const cols = [
            { name: "Payout", field: "payout", format: commaFormat },
            { name: "Points", field: "points", format: noFormat },
            { name: "Wins", field: "wins", format: noFormat },
            { name: "Elim Pts", field: "elims", format: noFormat },
            { name: "Elim %", field: "elimPct", format: pctFormat },
            { name: "Qual Pts", field: "placementPoints", format: noFormat },
            { name: "Qual %", field: "placementPct", format: pctFormat }
        ];

        function columnHeaders() {
            const rowHeaderWidth = 220;
            matchG.selectAll(".player-stat-col-header").data(cols).enter().append("text")
                .attr("x", (d, i) => rowHeaderWidth + ((i + 2) * colWidth) - 10)
                .attr("y", 30)
                .attr("pointer-events", "none")
                .classed("player-stat-col-header", true)
                .text(d => d.name);
        }

        function totals(totals) {
            const y = 63;
            text("Total", matchG, "player-stat-summary", leftMargin, y);

            cols.forEach(function (col, colNum) {
                const toShow = col.format(totals[col.field]).toString()
                text(
                    toShow,
                    matchG,
                    "player-stat-summary",
                    rowHeaderWidth + (colNum * colWidth) -
                    // Source Sans Pro has monospaced numbers, but commas are narrower than numbers
                    (toShow.length * 11) +
                    ((toShow.match(/,/g) || []).length) * 6,
                    y)
            });
        }

        function rows(formatWeeks, formatSummary, priorRowsHeight) {
            const rowHeight = 26;
            const summaryRowHeight = 40;

            // Summary row for Trio / Solo / Duo
            if (!formatSummary)  // This is a bug..
                return priorRowsHeight + summaryRowHeight;

            text(formatSummary.key, matchG, "player-stat-summary", leftMargin, priorRowsHeight + 14);
            cols.forEach(function (col, colNum) {
                const toShow = col.format(formatSummary.value[col.field]).toString()
                text(
                    toShow,
                    matchG,
                    "player-stat-summary",
                    rowHeaderWidth + (colNum * colWidth) -
                    // Source Sans Pro has monospaced numbers, but commas are narrower than numbers
                    (toShow.length * 11) +
                    ((toShow.match(/,/g) || []).length) * 6,
                    priorRowsHeight + 8)
            });

            // Week rows
            formatWeeks.values.forEach((week, rowNum) => {
                const y = + priorRowsHeight + summaryRowHeight + (rowHeight * rowNum);
                text("# " + week.rank + " " + week.week, matchG, "player-stat-row", leftMargin + 16, y);

                const left = rowHeaderWidth + (cols.length * colWidth) - 60;

                let partners = []
                if (week.soloOrDuo != "Solo")
                    partners = getPartners(week.region, week.rank, week.week, week.player);

                if (partners.length === 1)
                    text("w / " + partners[0].player, matchG, "player-stat-row", left, y);
                if (partners.length === 2)
                    text("w / " + partners[0].player + " & " + partners[1].player, matchG, "player-stat-row", left, y);

                cols.forEach(function (col, colNum) {
                    const toShow = col.format(week[col.field]).toString()
                    text(
                        toShow,
                        matchG,
                        "player-stat-row",
                        rowHeaderWidth + (colNum * colWidth) -
                        // Source Sans Pro has monospaced numbers, but commas are narrower than numbers
                        (toShow.length * 9.5) +
                        ((toShow.match(/,/g) || []).length) * 6.2,
                        y)
                });
            });
            return priorRowsHeight + summaryRowHeight + (formatWeeks.values.length * rowHeight);
        }

        function getPartners(region, rank, week, player) {
            // Could be made faster, but fine for now
            return data.filter(d => (d.region === region) && (d.rank === rank) && (d.week === week) && (d.player != player));
        }


        const formatWeeks = d3.nest()
            .key(function (d) { return d.soloOrDuo; })
            .entries(recs);

        const formatSummaries = d3.nest()
            .key(function (d) { return d.soloOrDuo; })
            .rollup(function (v) {
                return {
                    payout: d3.sum(v, d => d.payout),
                    points: d3.sum(v, d => d.points),
                    wins: d3.sum(v, d => d.wins),
                    elims: d3.sum(v, d => d.elims),
                    placementPoints: d3.sum(v, d => d.placementPoints),
                };
            })
            .entries(recs);

        formatSummaries.forEach(function (d) {
            d.value.elimPct = d.value.elims / d.value.points;
            d.value.placementPct = d.value.placementPoints / d.value.points;
        })

        let total = {};
        total.payout = d3.sum(recs, d => d.payout);
        total.points = d3.sum(recs, d => d.points);
        total.wins = d3.sum(recs, d => d.wins);
        total.elims = d3.sum(recs, d => d.elims);
        total.elimPct = d3.sum(recs, d => d.elims) / d3.sum(recs, d => d.points);
        total.placementPoints = d3.sum(recs, d => d.placementPoints);
        total.placementPct = d3.sum(recs, d => d.placementPoints) / d3.sum(recs, d => d.points);

        text("Match", matchG, "g-header", 30, 40);

        columnHeaders();
        totals(total);

        let priorRowsHeight = 100;
        priorRowsHeight = rows(formatWeeks[2], formatSummaries[2], priorRowsHeight);
        priorRowsHeight = rows(formatWeeks[1], formatSummaries[1], priorRowsHeight);
        rows(formatWeeks[0], formatSummaries[0], priorRowsHeight);
    }

    const num = d3.format(",d");

    const recs = facts.all().filter(x => x.player === player);
    recs.forEach(function (d) {
        d.elimPct = d.elims / d.points;
        d.placementPct = d.placementPoints / d.points;
    });
    if (recs.length == 0)
        return;

    enableSvgs(false);
    makeSvg();

    const region = recs[0].region;
    const stats = statsForPlayer(region, player);  // In main

    
    makeHeader(stats);
    makeRanks(stats, region);
    makeTrends(recs, region);
    makeMatches(recs);
}