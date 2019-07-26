import { colors } from "./shared.js";

let games;
let teams;


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

    console.log("HI");
    console.log(teams);

    draw();
});

function draw() {
    //console.log(games);
    console.log(teams);

    let div = d3.select(".timeline");

    const chartWidth = 1200
    const svg = div.append("svg")
        .attr("width", chartWidth)
        .attr("height", 1000)

    const rowHeight = 60
    svg.selectAll("g").data(teams).enter().append("g")
        .append("rect")
        .attr("x", 0)
        .attr("y", (d, i) => i * rowHeight)
        .attr("width", chartWidth)
        .attr("height", rowHeight - 8)
        .attr("fill", "lightblue")
        .attr("stroke", "black")
        .attr("stroke-width", 2)

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

    const beforeStart = teams[0].values[0].endSeconds - teams[0].values[0].secondsAlive;
    const start =
        teams[0].values[0].endSeconds -
        teams[0].values[0].secondsAlive -
        beforeStart;

    const end = start + (60 * 60 * 3.6);

    //const startSeconds =
    //    teams[0].values[0].endSeconds - teams[0].values[0].secondsAlive;
    //const endSeconds = startSeconds + (60 * 60 * 3.6);

    let xScale = d3.scaleLinear()
        .domain([start, end])
        .range([200, chartWidth]);

    svg.selectAll("g").data(teams).append("rect")
        .attr("x", d => xScale(start))
        .attr("y", (d, i) => i * rowHeight + 5)
        .attr("width", d => xScale(d.values[0].endSeconds))
        .attr("height", 43)
        .attr("fill", "white")
        .attr("stroke", "black")
        .attr("stroke", "black")
        .attr("stroke-width", 2)
}