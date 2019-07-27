import { colors } from "./shared.js";

let teams;

let matchStart;
let matchEnd;

const cornerRadius = 8;

const chartWidth = 1200 // Not including left margin
const leftMargin = 15;

let regions = [];


d3.json('fwc/data/games.json').then(function (data) {
    let games = [];
    data.forEach(function (d) {
        let rec = {};
        //rec.name = d.fields[0];
        rec.secondsAlive = d.fields[0];
        rec.endTime = d.fields[1];
        rec.rank = d.fields[2];
        rec.elims = d.fields[3];
        rec.endSeconds = d.fields[4];
        rec.placementPoints = d.fields[5];
        rec.placementId = d.fields[6];
        rec.placementRank = d.fields[7];

        rec.players = [];
        rec.players[0] = d.players[0];
        rec.players[1] = d.players[1];

        games.push(rec);
    });

    teams = d3.nest()
        .key(d => d.placementRank)
        .entries(games);

    const beforeMatch =
        teams[0].values[0].endSeconds -
        teams[0].values[0].secondsAlive - 100; // First started late

    matchStart = 0;
    matchEnd = 60 * 60 * 3.4;

    teams.forEach(function (team) {

        // Add extra fields to each game
        team.values.forEach(function (game) {
            // Normalize seconds to start of match = 0
            game.start = game.endSeconds - beforeMatch - game.secondsAlive;
            game.end = game.endSeconds - beforeMatch;
            //console.log(game.start + " -> " + game.end);

            // Add nice time string
            const minutes = Math.floor(game.secondsAlive / 60);
            const seconds = game.secondsAlive - minutes * 60;
            game.time = minutes + ":" + ((seconds.toString().length == 1) ? "0" + seconds : seconds);
        })

        // Add team level sum of elims and placement points
        team.elims = d3.sum(team.values, game => game.elims);
        team.placementPoints = d3.sum(team.values, game => game.placementPoints);
        team.games = team.values.length;
    })

    drawHeader();
    drawLeaderboard();
});

function drawHeader() {

    const regionInfo = [
        { color: colors.green, name: "NA EAST", filter: "NA East", textOffset: 8 },
        { color: colors.purple, name: "NA WEST", filter: "NA West", textOffset: 6 },
        { color: colors.blue, name: "EUROPE", filter: "Europe", textOffset: 9 },
        { color: colors.red, name: "OCEANIA", filter: "Oceania", textOffset: 6 },
        { color: colors.teal, name: "BRAZIL", filter: "Brazil", textOffset: 12 },
        { color: colors.brown, name: "ASIA", filter: "Asia", textOffset: 17 }
    ];

    function drawButtons() {
        const left = 740
        regionInfo.forEach(function (region, i) {
            svg.append("rect")
                .attr("data", region.name)
                .attr("x", left + (i * 80))
                .attr("y", 19)
                .attr("width", 70)
                .attr("height", 50)
                .attr("fill", region.color)
                .attr("stroke", "black")
                .attr("stroke-width", 0)
                .attr("rx", cornerRadius)
                .attr("ry", cornerRadius)
                .on('mouseover', function (d) {
                    // The are mousing over the selected item - don't shrink the border
                    //    if (d3.select(this).attr("data") === filters.region)
                    //        return;

                    d3.select(this)
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 4)
                })
                .on('mouseout', function (d) {
                    let dom = d3.select(this);
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", (regions.indexOf(dom.attr("data")) == -1) ? 0 : 8);
                })
                .on('click', function (d) {
                    let dom = d3.select(this);
                    const region = dom.attr("data");

                    // Select it because it is not already selected
                    if (regions.indexOf(region) == -1)
                        regions.push(region)
                    else
                        regions = regions.filter(d => d !== region);

                    drawLeaderboard();
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", (regions.indexOf(dom.attr("data")) == -1) ? 0 : 8);
                })

            svg.append("text")
                .attr("x", left + region.textOffset + (i * 80))
                .attr("y", 51)
                .attr("stroke", "black")
                .attr("stroke-width", 0)
                .attr("font-size", "1.2rem")
                .attr("pointer-events", "none")
                .text(region.name)
        });
    }

    const headerHeight = 76;
    let div = d3.select(".title");
    const svg = div.append("svg")
        .attr("width", leftMargin + chartWidth)
        .attr("height", headerHeight);

    // "FORTNITE"    
    svg.append("text")
        .attr("x", 20)
        .attr("y", 60)
        .text("FORTNITE 2019 World Cup Duos")
        .attr("font-size", "1.1em")
        .attr("fill", "black");

    drawButtons();
}

function drawLeaderboard() {

    // Apply region filters here!!
    console.log("Filters: " + regions.join(", "))

    let div = d3.select(".timeline");

    const playerWidth = 220;
    const rowHeight = 60

    const svg = div.append("svg")
        .attr("width", chartWidth + leftMargin)
        .attr("height", rowHeight * 100)

    // Big rect for team background 
    svg.selectAll("g").data(teams).enter().append("g")
        .append("rect")
        .attr("x", leftMargin)
        .attr("y", (d, i) => i * rowHeight + 3)
        .attr("width", chartWidth - 3)
        .attr("height", rowHeight - 8)
        .attr("fill", "lightblue")
        .attr("stroke", "black")
        .attr("stroke-width", 0)
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)

    // Rank
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + 6)
        .attr("y", (d, i) => i * rowHeight + 40)
        .text(d => d.key)
        .classed("rank", true)

    // Points   
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + 45)
        .attr("y", (d, i) => i * rowHeight + 30)
        .text(d => d.elims + d.placementPoints)
        .classed("rank", true)

    // Games   
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + 40)
        .attr("y", (d, i) => i * rowHeight + 50)
        .text(d => d.games)
        .classed("points", true)

    // Placement points   
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + 60)
        .attr("y", (d, i) => i * rowHeight + 50)
        .text(d => d.placementPoints)
        .classed("points", true)

    // Elims   
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + 85)
        .attr("y", (d, i) => i * rowHeight + 50)
        .text(d => d.elims)
        .classed("points", true)

    // First player
    const leftPlayer = 120;
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + leftPlayer)
        .attr("y", (d, i) => i * rowHeight + 21)
        .text(d => d.values[0].players[0])
        .classed("player", true)

    // Second player    
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + leftPlayer)
        .attr("y", (d, i) => i * rowHeight + 45)
        .text(d => d.values[0].players[1])
        .classed("player", true)

    // Draw game rects    
    let xScale = d3.scaleLinear()
        .domain([matchStart, matchEnd])
        .range([playerWidth + leftMargin, chartWidth]);

    svg.selectAll("g").data(teams)
        .each(function (teamGames, teamIndex) {

            // Debugging..
            if (teamIndex == 1) {
                let game1 = teamGames.values[1];
                /*                 console.log("x = " + xScale(game1.start));
                                console.log("Width = " + (xScale(game1.end) - xScale(game1.start)).toString())
                                console.log(""); */
            }

            const g = d3.select(this);

            g
                .selectAll("rect")

                .data(teamGames.values)
                .enter()
                .append("rect")
                .attr("x", game => xScale(game.start))
                .attr("x", function (game) {
                    return xScale(game.start)
                    //console.log(game.start + " -> " + game.end + "  " + game.secondsAlive);
                })
                .attr("y", (d, i) => teamIndex * rowHeight + 14)
                .attr("width", game => xScale(game.end) - xScale(game.start))
                .attr("height", 30)
                .attr("fill", "white")
                .attr("stroke", "black")
                .attr("stroke-width", game => (game.rank === "1") ? 6 : 1)
                .on('click', function (game) {
                    console.log(game.start + " -> " + game.end + "  " + game.secondsAlive);
                })
                .on('mouseover', game => tooltip(svg, game))
                .on('mouseout', function (d) {
                    d3.select(this).attr("stroke-width", 1)
                    d3.selectAll(".tooltip").remove();
                })

                // Draw elim lines
                .each(function (game) {
                    for (let i = 0; i < game.elims; i++) {
                        const x = xScale(game.start) + (i * 4) + 6;
                        g
                            .append("line")
                            .attr("x1", x)
                            .attr("x2", x)
                            .attr("y1", teamIndex * rowHeight + 17)
                            .attr("y2", teamIndex * rowHeight + 14 + 27)
                            .attr("stroke-width", "2")
                            .attr("stroke", "green")
                            .attr("pointer-events", "none");
                    }
                    //console.log(game.elims);
                });
        })
}


function tooltip(svg, game) {

    const rectWidth = 148;
    let left = d3.event.pageX - 150;

    const top = d3.event.pageY - 120;
    const height = 94;

    svg.append("rect")
        .attr("x", left - 12)
        .attr("y", top)

        .attr("width", rectWidth)
        .attr("height", height)
        .attr("fill", "white")
        .attr("stroke", "black")
        .attr("stroke-width", 3)
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)
        .attr("font-size", "1.4em")
        .classed("tooltip", true);

    function addText(text, yOffset) {
        const leftText = left;
        svg.append("text")
            .attr("x", leftText)
            .attr("y", d3.event.pageY - yOffset)
            .text(text)
            .classed("tooltip", true)
            .classed("tooltip-text", true);
    }

    addText(parseInt(game.placementPoints) + parseInt(game.elims) + "  Total points", 98)
    addText(game.placementPoints + "  Placement points", 78)
    addText(game.elims + "  Elim points", 58)
    addText(game.time + "  Duration", 38)

    d3.select(this)
        .attr("stroke-width", 4)
}