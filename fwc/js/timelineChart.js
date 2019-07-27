import { colors } from "./shared.js";

let games;
let teams;

let matchStart;
let matchEnd;


d3.json('fwc/data/games.json').then(function (data) {
    games = [];
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

        rec.players = [];
        rec.players[0] = d.players[0];
        rec.players[1] = d.players[1];

        games.push(rec);
    });

    teams = d3.nest()
        .key(d => d.placementId)
        .entries(games);

    const beforeMatch =
        teams[0].values[0].endSeconds -
        teams[0].values[0].secondsAlive - 100; // First started late

    matchStart = 0;
    matchEnd = 60 * 60 * 3.4;

    teams.forEach(function (team) {
        team.values.forEach(function (game) {
            game.start = game.endSeconds - beforeMatch - game.secondsAlive;
            game.end = game.endSeconds - beforeMatch;
            console.log(game.start + " -> " + game.end);
        })
    })

    draw();
});

function draw() {

    let div = d3.select(".timeline");

    const chartWidth = 1200
    const playerWidth = 180;
    const svg = div.append("svg")
        .attr("width", chartWidth)
        .attr("height", 1000)

    const rowHeight = 60
    svg.selectAll("g").data(teams).enter().append("g")
        .append("rect")
        .attr("x", 3)
        .attr("y", (d, i) => i * rowHeight + 3)
        .attr("width", chartWidth - 3)
        .attr("height", rowHeight - 8)
        .attr("fill", "lightblue")
        .attr("stroke", "black")
        .attr("stroke-width", 5)

    svg.selectAll("g").data(teams)
        .append("text")  // 
        .attr("x", 6)
        .attr("y", (d, i) => i * rowHeight + 21)
        .text(d => d.values[0].players[0])
        .attr("font-family", "Helvetica, Arial, sans-serif")
        .attr("font-size", "1.0em")
        .attr("font-weight", "600")
        .attr("fill", "black")

    svg.selectAll("g").data(teams)
        .append("text")  // 
        .attr("x", 6)
        .attr("y", (d, i) => i * rowHeight + 45)
        .text(d => d.values[0].players[1])
        .attr("font-family", "Helvetica, Arial, sans-serif")
        .attr("font-size", "1.0em")
        .attr("font-weight", "600")
        .attr("fill", "black")

    console.log(matchStart + " " + matchEnd)

    let xScale = d3.scaleLinear()
        .domain([matchStart, matchEnd])
        .range([playerWidth, chartWidth - 5]);

    svg.selectAll("g").data(teams)
        .each(function (teamGames, teamIndex) {
            console.log(teamGames);
            d3.select(this)
                .selectAll("rect")
                .data(teamGames.values)
                .enter()
                .append("rect")
                .attr("x", function (game) {
                    console.log(game.start);
                    return xScale(game.start)
                })
                .attr("y", (d, i) => teamIndex * rowHeight + 14)
                .attr("width", game => xScale(game.end) - xScale(game.start))
                .attr("height", 30)
                .attr("fill", "white")
                .attr("stroke", "black")
                .attr("stroke-width", 2)
                .on('click', function (game) {
                    console.log(game.start + " -> " + game.end + "  " + game.secondsAlive);
                });
        })
}