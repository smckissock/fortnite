import { colors } from "./shared.js";

let teams;

let matchStart;
let matchEnd;


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

        // Normalize seconds to start of match = 0
        team.values.forEach(function (game) {
            game.start = game.endSeconds - beforeMatch - game.secondsAlive;
            game.end = game.endSeconds - beforeMatch;
            console.log(game.start + " -> " + game.end);
        })

        // Add team level sum of elims and placement points
        team.elims = d3.sum(team.values, game => game.elims);
        team.placementPoints = d3.sum(team.values, game => game.placementPoints);
    })

    drawHeader();
    draw();
});

function drawHeader() {
    const headerHeight = 70;
    let div = d3.select(".title");
    const svg = div.append("svg")
        .attr("width", 1000)
        .attr("height", headerHeight);

    // "FORTNITE"    
    svg.append("text")
        .attr("x", 20)
        .attr("y", 60)
        .text("FORTNITE 2019 World Cup Duos")
        .attr("font-size", "1.1em")
        .attr("fill", "black");
}

function draw() {

    let div = d3.select(".timeline");

    const chartWidth = 1200 // Not including left margin
    const leftMargin = 15;
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

    // Rank
    svg.selectAll("g").data(teams)
        .append("text")  // 
        .attr("x", leftMargin + 6)
        .attr("y", (d, i) => i * rowHeight + 40)
        .text(d => d.key)
        .classed("rank", true)

    // Points   
    svg.selectAll("g").data(teams)
        .append("text")  // 
        .attr("x", leftMargin + 45)
        .attr("y", (d, i) => i * rowHeight + 30)
        .text(d => d.elims + d.placementPoints)
        .classed("rank", true)

    // Placement points   
    svg.selectAll("g").data(teams)
        .append("text")  // 
        .attr("x", leftMargin + 45)
        .attr("y", (d, i) => i * rowHeight + 50)
        .text(d => d.placementPoints)
        .classed("points", true)

    // Elims   
    svg.selectAll("g").data(teams)
        .append("text")  // 
        .attr("x", leftMargin + 75)
        .attr("y", (d, i) => i * rowHeight + 50)
        .text(d => d.elims)
        .classed("points", true)

    // First player
    const leftPlayer = 120;
    svg.selectAll("g").data(teams)
        .append("text")  // 
        .attr("x", leftMargin + leftPlayer)
        .attr("y", (d, i) => i * rowHeight + 21)
        .text(d => d.values[0].players[0])
        .classed("player", true)

    // Second player    
    svg.selectAll("g").data(teams)
        .append("text")  // 
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
            console.log(teamGames);
            d3.select(this)
                .selectAll("rect")
                .data(teamGames.values)
                .enter()
                .append("rect")
                .attr("x", game => xScale(game.start))
                .attr("y", (d, i) => teamIndex * rowHeight + 14)
                .attr("width", game => xScale(game.end) - xScale(game.start))
                .attr("height", 30)
                .attr("fill", "white")
                .attr("stroke", "black")
                .attr("stroke-width", game => (game.rank === "1") ? 6 : 1)
                .on('click', function (game) {
                    console.log(game.start + " -> " + game.end + "  " + game.secondsAlive);
                });
        })
}