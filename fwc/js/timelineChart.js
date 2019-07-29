import { colors } from "./shared.js";

let teams;

let matchStart;
let matchEnd;

const cornerRadius = 8;

const chartWidth = 1200 // Not including left margin
const leftMargin = 15;

let regions = [];

let regionTotals;

const commaFormat = d3.format(",");

const regionInfo = [
    { color: colors.green, name: "NA EAST", filter: "NA East", textOffset: 8 },
    { color: colors.purple, name: "NA WEST", filter: "NA West", textOffset: 6 },
    { color: colors.blue, name: "EUROPE", filter: "Europe", textOffset: 9 },
    { color: colors.red, name: "OCEANIA", filter: "Oceania", textOffset: 6 },
    { color: colors.teal, name: "BRAZIL", filter: "Brazil", textOffset: 12 },
    { color: colors.brown, name: "ASIA", filter: "Asia", textOffset: 17 }
];


d3.json('fwc/data/duo_games.json').then(function (data) {
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

    addRegions(teams);

    regionTotals = d3.nest()
        .key(team => team.region)
        .rollup(function (teams) {
            return {
                count: teams.length,
                payout: d3.sum(teams, function (team) { return team.payout; })
            };
        })
        .entries(teams);

    regionInfo.forEach(function (region) {
        region.count = regionTotals.find(r => r.key == region.name).value.count;
        region.payout = regionTotals.find(r => r.key == region.name).value.payout;
    });

    const beforeMatch =
        teams[0].values[0].endSeconds -
        teams[0].values[0].secondsAlive - 100; // First started late

    matchStart = 0;
    matchEnd = 60 * 60 * 4.5;

    teams.forEach(function (team) {

        // Add extra fields to each game
        team.values.forEach(function (game) {
            // Normalize seconds to start of match = 0
            game.start = game.endSeconds - beforeMatch - game.secondsAlive;
            game.end = game.endSeconds - beforeMatch;

            // Add nice time string
            const minutes = Math.floor(game.secondsAlive / 60);
            const seconds = game.secondsAlive - minutes * 60;
            game.time = minutes + ":" + ((seconds.toString().length == 1) ? "0" + seconds : seconds);
        })

        // Add team level sum of elims and placement points
        team.elims = d3.sum(team.values, game => game.elims);
        team.placementPoints = d3.sum(team.values, game => game.placementPoints);
        team.games = team.values.length;
    });

    drawHeader();
    drawLeaderboard();
});

function drawHeader() {

    function drawButtons() {
        const left = 740
        regionInfo.forEach(function (region, i) {
            svg.append("rect")
                .attr("data", region.name)
                .attr("x", left + (i * 80))
                .attr("y", 3)
                .attr("width", 70)
                .attr("height", 70)
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
                        .attr("stroke-width", 3)
                })
                .on('mouseout', function (d) {
                    let dom = d3.select(this);
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", (regions.indexOf(dom.attr("data")) == -1) ? 0 : 6);
                })
                .on('click', function (d) {
                    let dom = d3.select(this);
                    const region = dom.attr("data");

                    // Select it because it is not already selected
                    if (regions.indexOf(region) == -1)
                        regions.push(region)
                    else
                        regions = regions.filter(d => d !== region);

                    updateLeaderboard();
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", (regions.indexOf(dom.attr("data")) == -1) ? 0 : 6);
                })

            svg.append("text")
                .attr("x", left + region.textOffset + (i * 80))
                .attr("y", 25)
                .attr("font-size", "1.2rem")
                .attr("pointer-events", "none")
                .text(region.name)

            svg.append("text")
                .attr("x", left + (i * 80) + 6)
                .attr("y", 43)
                .text(region.count.toString() + " players")
                .classed("region-stats", true)

            svg.append("text")
                .attr("x", left + (i * 80) + 4)
                .attr("y", 64)
                .attr("font-size", "0.6rem")
                .text("$" + commaFormat(region.payout))
                .classed("region-stats", true)
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
        .text("FORTNITE World Cup Duos")
        .attr("font-size", "1.1em")
        .attr("fill", "black");

    drawButtons();
}

function updateLeaderboard() {
    let includedTeams = teams.filter(team => regions.includes(team.region));

    let x = d3.selectAll(".leaderboard-team")
        .each(function (team, i) {
            const dom = d3.select(this);
            const curY = team.y;

            let y = -1;
            if (includedTeams.length == 0) {
                y = i * 60;
            } else {
                for (var i = 0; i < includedTeams.length; i++) {
                    const includedTeam = includedTeams[i]
                    if (includedTeam.key == team.key) {
                        console.log(dom.attr())
                        y = i * 60;  // RowHeight;
                        console.log(y)
                    }
                }
            }

            const toMove = y - curY;
            const duration = 400;
            if (y == -1)
                dom.transition()
                    .duration(duration)
                    .style("opacity", "0")
            else
                dom
                    .transition()
                    .duration(duration)
                    .style("opacity", "1")
                    .attr("transform", "translate(0," + toMove + ")");
        });
}

function drawLeaderboard() {

    function filterTeams() {
        return teams;
    }

    // Apply region filters here!!
    console.log("Filters: " + regions.join(", "))

    let div = d3.select(".timeline");

    const playerWidth = 220;
    const rowHeight = 60

    const svg = div.append("svg")
        .attr("width", chartWidth + leftMargin)
        .attr("height", rowHeight * 100)
        .classed("leaderboard-svg", true);

    // Big rect for team background 
    svg.selectAll("g").data(filterTeams()).enter().append("g")
        .classed("leaderboard-team", true)
        .append("rect")
        .attr("x", leftMargin)
        .attr("y", function (d, i) {
            let y = i * rowHeight + 3;
            d.y = y;
            return y;
        })
        .attr("width", chartWidth - 3)
        .attr("height", rowHeight - 8)
        .attr("fill", function (team) {
            return regionInfo.filter(region => region.name == team.region)[0].color;
        })
        .attr("stroke", "black")
        .attr("stroke-width", 0)
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)

    // Labels on the left

    // Rank
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + 23)
        .attr("y", (d, i) => i * rowHeight + 31)
        .text(d => "#" + d.key.toString())
        .classed("rank", true)

    // Payout    
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + 15)
        .attr("y", (d, i) => i * rowHeight + 48)
        .text(d => "$" + commaFormat(d.payout.toString()))
        .classed("points", true)

    // First player
    const leftPlayer = 90;
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + leftPlayer)
        .attr("y", (d, i) => i * rowHeight + 23)
        .text(d => d.values[0].players[0])
        .classed("player", true)

    // Second player    
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", leftMargin + leftPlayer)
        .attr("y", (d, i) => i * rowHeight + 48)
        .text(d => d.values[0].players[1])
        .classed("player", true)


    // Labels on the right 

    // Points   
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", chartWidth - 135)
        .attr("y", (d, i) => i * rowHeight + 33)
        .text(d => d.elims + d.placementPoints)
        .classed("rank", true)

    // "Points"
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", chartWidth - 140)
        .attr("y", (d, i) => i * rowHeight + 49)
        .text("points")
        .classed("points", true)

    // Games   
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", chartWidth - 60)
        .attr("y", (d, i) => i * rowHeight + 20)
        .text(d => d.games)
        .classed("points", true)

    // Placement points   
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", chartWidth - 60)
        .attr("y", (d, i) => i * rowHeight + 35)
        .text(d => d.placementPoints)
        .classed("points", true)

    // Elims   
    svg.selectAll("g").data(teams)
        .append("text")
        .attr("x", chartWidth - 60)
        .attr("y", (d, i) => i * rowHeight + 50)
        .text(d => d.elims)
        .classed("points", true)


    // Draw game rects    
    let xScale = d3.scaleLinear()
        .domain([matchStart, matchEnd])
        .range([playerWidth + leftMargin, chartWidth]);

    svg.selectAll("g").data(teams)
        .each(function (teamGames, teamIndex) {
            const g = d3.select(this);
            g
                .selectAll("rect.team-rect")

                .data(teamGames.values)
                .enter()
                .append("rect")
                .attr("x", game => xScale(game.start))
                //.attr("x", function (game) {
                //    return xScale(game.start)
                //    //console.log(game.start + " -> " + game.end + "  " + game.secondsAlive);
                //})
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
                .on('mouseout', function (game) {
                    d3.select(this).attr("stroke-width", game => (game.rank === "1") ? 6 : 1)
                    d3.selectAll(".tooltip").remove();
                })
                .classed("team-rect", true)

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

function addRegions(teams) {
    let i = 1;
    function addRegion(region, payout) {
        let team = teams.filter(d => d.key == i.toString())[0];
        team.region = region;
        team.payout = payout;
        team.ordering = i;
        i++;
    }

    addRegion('EUROPE', 3000000); // 1
    addRegion('EUROPE', 2225000);
    addRegion('NA EAST', 1800000);
    addRegion('NA EAST', 1500000);
    addRegion('NA WEST', 900000);
    addRegion('EUROPE', 450000);
    addRegion('EUROPE', 375000);
    addRegion('EUROPE', 225000);
    addRegion('NA EAST', 100000);
    addRegion('EUROPE', 100000); // 10
    addRegion('EUROPE', 100000);
    addRegion('NA EAST', 100000);
    addRegion('EUROPE', 100000);
    addRegion('EUROPE', 100000);
    addRegion('NA EAST', 100000);
    addRegion('NA EAST', 100000);
    addRegion('NA EAST', 100000);
    addRegion('OCEANIA', 100000);
    addRegion('EUROPE', 100000);
    addRegion('ASIA', 100000); // 20
    addRegion('EUROPE', 100000);
    addRegion('EUROPE', 100000);
    addRegion('EUROPE', 100000);
    addRegion('EUROPE', 100000);
    addRegion('EUROPE', 100000);
    addRegion('EUROPE', 100000);
    addRegion('ASIA', 100000);
    addRegion('NA EAST', 100000);
    addRegion('EUROPE', 100000);
    addRegion('NA EAST', 100000); // 30
    addRegion('NA EAST', 100000);
    addRegion('EUROPE', 100000);
    addRegion('EUROPE', 100000);
    addRegion('NA EAST', 100000);
    addRegion('NA EAST', 100000);
    addRegion('NA EAST', 100000);
    addRegion('NA EAST', 100000);
    addRegion('NA EAST', 100000);
    addRegion('EUROPE', 100000);
    addRegion('OCEANIA', 100000); // 40
    addRegion('NA EAST', 100000);
    addRegion('NA EAST', 100000);
    addRegion('BRAZIL', 100000);
    addRegion('EUROPE', 100000);
    addRegion('EUROPE', 100000);
    addRegion('NA EAST', 100000);
    addRegion('BRAZIL', 100000);
    addRegion('BRAZIL', 100000);
    addRegion('ASIA', 100000);
    addRegion('OCEANIA', 100000);
};