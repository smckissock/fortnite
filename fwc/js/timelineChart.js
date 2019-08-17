import { colors } from "./shared.js";


let matchStart;
let matchEnd;

const cornerRadius = 8;

const chartWidth = 1200 // Not including left margin
const leftMargin = 15;

let regions = [];
let solosOrDuos = "Duos";

let titleText;
let toggleButtonText;

let xScale;

let format = {
    teams: null,
    regionTotals: null,
    beforeMatch: null
}

const isLan = true;

// One of these is assigned to format at all times   
let solos = {};
let duos = {};
format = duos;

let regionTotals;
const toggleLeft = 626;
const playerWidth = 400;

const commaFormat = d3.format(",");

const regionInfo = [
    { color: colors.green, name: "NA EAST", filter: "NA East", textOffset: 5 },
    { color: colors.purple, name: "NA WEST", filter: "NA West", textOffset: 4 },
    { color: colors.blue, name: "EUROPE", filter: "Europe", textOffset: 6 },
    { color: colors.red, name: "OCEANIA", filter: "Oceania", textOffset: 4 },
    { color: colors.teal, name: "BRAZIL", filter: "Brazil", textOffset: 11 },
    { color: colors.brown, name: "ASIA", filter: "Asia", textOffset: 18 }
];


//d3.json('fwc/data/duo_games.json').then(function (data) {
d3.json('fwc/data/finals.json').then(function (data) {
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
        rec.week = d.fields[8];

        rec.players = [];
        rec.players[0] = d.players[0];

        // Will only be one for solo
        if (d.players[1])
            rec.players[1] = d.players[1];

        games.push(rec);
    });

    let duoGames = games.filter(game => game.week === "11");
    let soloGames = games.filter(game => game.week === "12");

    duos.teams = d3.nest()
        .key(d => d.placementRank)
        .entries(duoGames);
    addDuoRegions(duos.teams);

    solos.teams = d3.nest()
        .key(d => d.placementRank)
        .entries(soloGames);
    addSoloRegions(solos.teams);

    duos.regionTotals = d3.nest()
        .key(team => team.region)
        .rollup(function (teams) {
            return {
                count: teams.length,
                payout: d3.sum(teams, function (team) { return team.payout; })
            };
        })
        .entries(duos.teams);

    solos.regionTotals = d3.nest()
        .key(team => team.region)
        .rollup(function (teams) {
            return {
                count: teams.length,
                payout: d3.sum(teams, function (team) { return team.payout; })
            };
        })
        .entries(solos.teams);

    regionInfo.forEach(function (region) {
        region.duosCount = duos.regionTotals.find(r => r.key == region.name).value.count;
        region.duosPayout = duos.regionTotals.find(r => r.key == region.name).value.payout;

        region.solosCount = solos.regionTotals.find(r => r.key == region.name).value.count;
        region.solosPayout = solos.regionTotals.find(r => r.key == region.name).value.payout;
    });

    duos.beforeMatch =
        duos.teams[0].values[0].endSeconds -
        duos.teams[0].values[0].secondsAlive - 100; // First started late

    solos.beforeMatch =
        solos.teams[0].values[0].endSeconds -
        solos.teams[0].values[0].secondsAlive - 100; // First started late

    matchStart = 0;
    matchEnd = 60 * 60 * 4.7;

    duos.teams.forEach(function (team) {

        // Add extra fields to each game
        team.values.forEach(function (game) {
            // Normalize seconds to start of match = 0
            game.start = game.endSeconds - duos.beforeMatch - game.secondsAlive;
            game.end = game.endSeconds - duos.beforeMatch;

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

    solos.teams.forEach(function (team) {

        // Add extra fields to each game
        team.values.forEach(function (game) {
            // Normalize seconds to start of match = 0
            game.start = game.endSeconds - solos.beforeMatch - game.secondsAlive;
            game.end = game.endSeconds - solos.beforeMatch;

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

    xScale = d3.scaleLinear()
        .domain([matchStart, matchEnd])
        .range([playerWidth + leftMargin, chartWidth + 170]);

    drawHeader();
    drawGameHeaders();
    drawLeaderboard();
});


function drawHeader() {

    function drawButtons() {
        const left = 740
        const buttonHeight = 80;
        regionInfo.forEach(function (region, i) {
            svg.append("rect")
                .attr("data", region.name)
                .attr("x", left + (i * 80))
                .attr("y", 3)
                .attr("width", 70)
                .attr("height", buttonHeight)
                .attr("fill", region.color)
                .attr("stroke", "black")
                .attr("stroke-width", 0)
                .attr("rx", cornerRadius)
                .attr("ry", cornerRadius)
                .on('mouseover', function (d) {
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
                .attr("y", 30)
                .attr("font-size", "1.2rem")
                .attr("pointer-events", "none")
                .text(region.name)
                .classed("region-name", true)

            let teamType = ((solosOrDuos == "Solos") ? " players" : " duos");
            region.countText = svg.append("text")
                .attr("x", left + (i * 80) + 6)
                .attr("y", 48)
                .text((solosOrDuos == "Solos") ? region.solosCount.toString() : region.duosCount.toString() + teamType)
                .classed("region-stats", true)

            region.payoutText = svg.append("text")
                .attr("x", left + (i * 80) + 4)
                .attr("y", 69)
                .attr("font-size", "0.6rem")
                .text("$" + ((solosOrDuos == "Solos") ? commaFormat(region.solosPayout) : commaFormat(region.duosPayout)))
                .classed("region-stats", true)
        }); // End region buttons

        let opacity = 1;
        let solosOrDuosButton = svg.append("rect")
            .attr("x", 630)
            .attr("y", 3)
            .attr("width", 100)
            .attr("height", buttonHeight)
            .attr("fill", "lightblue")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("rx", cornerRadius)
            .attr("ry", cornerRadius)
            .attr("opacity", opacity)
            .on('mouseover', function (d) {
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 3);
            })
            .on('mouseout', function (d) {
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 0);
            })
            .on('click', function (d) {
                toggleSolosOrDuos();
            });

        // "Switch to"
        svg.append("text")
            .attr("x", toggleLeft + 15)
            .attr("y", 35)
            .text("Switch to")
            .attr("font-family", "Source Sans Pro, sans-serif")
            .attr("font-size", "1.2rem")
            .attr("pointer-events", "none")
            .attr("opacity", opacity)

        toggleButtonText = svg.append("text")
            .attr("x", toggleLeft + ((solosOrDuos == "Duos") ? 16 : 20))
            .attr("y", 64)
            .text(d => otherFormat())
            .attr("font-family", "Source Sans Pro, sans-serif")
            .attr("font-size", "1.4rem")
            .attr("pointer-events", "none")
            .attr("opacity", opacity)


        // Switch to Qualifiers
        const qualifierLeft = 520
        let qualifierButton = svg.append("a")
            .attr("xlink:href", "https://fortnitewc.netlify.com")
            .append("rect")
            .attr("x", qualifierLeft)
            .attr("y", 3)
            .attr("width", 100)
            .attr("height", buttonHeight)
            .attr("fill", "lightblue")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("rx", cornerRadius)
            .attr("ry", cornerRadius)
            .on('mouseover', function (d) {
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 3);
            })
            .on('mouseout', function (d) {
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 0);
            })

        // "Switch to"
        svg.append("text")
            .attr("x", qualifierLeft + 8)
            .attr("y", 35)
            .text("Switch to")
            .attr("font-family", "Source Sans Pro, sans-serif")
            .attr("font-size", "1.2rem")
            .attr("pointer-events", "none")

        // Qualifier    
        svg.append("text")
            .attr("x", qualifierLeft + 7)
            .attr("y", 62)
            .text("Qualifiers")
            .attr("font-family", "Source Sans Pro, sans-serif")
            .attr("font-size", "1.2rem")
            .attr("pointer-events", "none")
    }

    const headerHeight = 86;
    let div = d3.select(".title");
    const svg = div.append("svg")
        .attr("width", leftMargin + chartWidth)
        .attr("height", headerHeight);

    // "FORTNITE"    
    titleText = svg.append("text")
        .attr("x", 20)
        .attr("y", 56)
        .text("FORTNITE World Cup " + solosOrDuos)
        .attr("font-size", "1.1em")
        .attr("font-family", "burbank")
        .attr("fill", "black");

    // Creator Code
    const posickTop = 84
    svg.append("text")
        .attr("x", 20)
        .attr("y", posickTop)
        .text("USE CREATOR CODE")
        .attr("font-family", "Source Sans Pro, sans-serif")
        .attr("font-size", "1.0rem")

    // Posick
    svg.append("text")
        .attr("x", 170)
        .attr("y", posickTop)
        .text('"Posick"')
        .attr("font-family", "Source Sans Pro, sans-serif")
        .attr("font-size", "1.4rem")
    //.classed("player", true);

    drawButtons();
}

function otherFormat() {
    return (solosOrDuos === "Solos") ? "Duos" : "Solos";
}

function toggleSolosOrDuos() {
    solosOrDuos = (solosOrDuos === "Solos") ? "Duos" : "Solos";
    format = (solosOrDuos === "Solos") ? solos : duos;

    titleText.text("FORTNITE World Cup " + solosOrDuos)
    toggleButtonText
        .transition()
        .text(otherFormat())
        .attr("x", toggleLeft + ((solosOrDuos == "Duos") ? 16 : 20));

    let teamType = ((solosOrDuos === "Solos") ? " players" : " duos");
    regionInfo.forEach(function (region) {
        region.countText.text((solosOrDuos == "Solos") ? region.solosCount.toString() + teamType : region.duosCount.toString() + teamType)
        region.payoutText.text("$" + ((solosOrDuos == "Solos") ? commaFormat(region.solosPayout) : commaFormat(region.duosPayout)));
    });

    //updateGameHeaders();

    d3.selectAll(".games-svg").remove();
    drawGameHeaders();

    d3.selectAll(".leaderboard-team").remove();
    d3.selectAll(".leaderboard-svg").remove();
    drawLeaderboard();
}


function updateLeaderboard() {
    let includedTeams = format.teams.filter(team => regions.includes(team.region));

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


function drawGameHeaders() {

    if (!isLan)
        return;

    const gameHeaderHeight = 40

    const div = d3.select(".timeline");
    const svg = div.append("svg")
        .attr("width", chartWidth + leftMargin)
        .attr("height", gameHeaderHeight)
        .classed("games-svg", true);

    const games = [{ num: 1 }, { num: 2 }, { num: 3 }, { num: 4 }, { num: 5 }, { num: 6 }];

    // Add the earliest start and the latest end to each game 
    games.forEach(function (game) {
        game.start = d3.min(format.teams, d => d.values[game.num - 1] ? d.values[game.num - 1].start : 99999999);
        game.end = d3.max(format.teams, d => d.values[game.num - 1] ? d.values[game.num - 1].end : 0);
    });

    // Boxes for game headers
    svg
        .selectAll("rect")
        .data(games)
        .enter()
        .append("rect")
        .attr("x", game => xScale(game.start))
        .attr("y", 0)
        .attr("width", game => xScale(game.end) - xScale(game.start))
        .attr("height", gameHeaderHeight)
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)
        .attr("fill", "lightblue")
        .attr("stroke", "black")
        .attr("stroke-width", 0)
        .attr("class", d => "game" + d.num);

    svg.selectAll("text.game").data(games).enter().append("text")
        .attr("x", game => xScale(game.start) + 8)
        .attr("y", 18)
        .text(game => "Game " + game.num)
        .classed("game", true);

    function formatSeconds(seconds) {
        return Math.floor(seconds / 60) + ':' + ('0' + Math.floor(seconds % 60)).slice(-2);
    }

    svg.selectAll("text.game-time").data(games).enter().append("text")
        .attr("x", game => xScale(game.start) + 8)
        .attr("y", 34)
        .text(game => formatSeconds(game.end - game.start))
        .classed("game-time", true)
    //.attr("class", d => "game-time-" + d.num);
}

// Not called. Supposed to transition the x and width of the game rectangles 
function updateGameHeaders() {

    function formatSeconds(seconds) {
        return Math.floor(seconds / 60) + ':' + ('0' + Math.floor(seconds % 60)).slice(-2);
    }

    const games = [{ num: 1 }, { num: 2 }, { num: 3 }, { num: 4 }, { num: 5 }, { num: 6 }];

    games.forEach(function (game) {
        game.start = d3.min(format.teams, d => d.values[game.num - 1] ? d.values[game.num - 1].start : 99999999);
        game.end = d3.max(format.teams, d => d.values[game.num - 1] ? d.values[game.num - 1].end : 0);
    });

    console.log(format.teams.length);
    console.log("");
    games.forEach(function (game) {
        const x = xScale(game.start);
        const width = xScale(game.end) - xScale(game.start) + 40;

        console.log(".game" + game.num + " " + x);
        const rect = d3.select(".game" + game.num);

        rect
            .transition()
            .duration(1000)
            //.attr("x", game => xScale(game.start) + 10)
            //.attr("width", game => xScale(game.end) - xScale(game.start) + 40)
            .attr("width", width)
            .attr("x", x)
        //.text(game => formatSeconds(game.end - game.start))

        const time = d3.select(".game-time-" + game.num);
        time.text = formatSeconds(game.end - game.start);
    });
}

function drawLeaderboard() {

    let div = d3.select(".timeline");
    const rowHeight = 60;

    const svg = div.append("svg")
        .attr("width", chartWidth + leftMargin)
        .attr("height", rowHeight * 100)
        .classed("leaderboard-svg", true);

    // Big rect for team background 
    svg.selectAll("g").data(format.teams).enter().append("g")
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
    svg.selectAll("g").data(format.teams)
        .append("text")
        .attr("x", leftMargin + 23)
        .attr("y", (d, i) => i * rowHeight + 31)
        .text(d => "#" + d.key.toString())
        .classed("rank", true)

    // Payout    
    svg.selectAll("g").data(format.teams)
        .append("text")
        .attr("x", leftMargin + 15)
        .attr("y", (d, i) => i * rowHeight + 48)
        .text(d => "$" + commaFormat(d.payout.toString()))
        .classed("points", true)

    // First player
    const leftPlayer = 90;
    svg.selectAll("g").data(format.teams)
        .append("text")
        .attr("x", leftMargin + leftPlayer)
        .attr("y", (d, i) => i * rowHeight + ((solosOrDuos == "Duos") ? 23 : 36))
        .text(d => d.values[0].players[0])
        .classed("player", true)

    // Second player    
    if (solosOrDuos == "Duos")
        svg.selectAll("g").data(format.teams)
            .append("text")
            .attr("x", leftMargin + leftPlayer)
            .attr("y", (d, i) => i * rowHeight + 48)
            .text(d => d.values[0].players[1])
            .classed("player", true)


    // Labels on the right 

    // Big Points   
    svg.selectAll("g").data(format.teams)
        .append("text")
        .attr("x", playerWidth - 145)
        .attr("y", (d, i) => i * rowHeight + 33)
        .text(d => d.elims + d.placementPoints)
        .classed("rank", true)

    // "Points" label
    svg.selectAll("g").data(format.teams)
        .append("text")
        .attr("x", playerWidth - 150)
        .attr("y", (d, i) => i * rowHeight + 49)
        .text("points")
        .classed("points", true)

    // Elim percentage  
    const pctFormat = d3.format(",.1%");
    svg.selectAll("g").data(format.teams)
        .append("text")
        .attr("x", playerWidth - 93)
        .attr("y", (d, i) => i * rowHeight + 20)
        .text(d => pctFormat(d.elims / (d.elims + d.placementPoints)) + " elim pct")
        .classed("points", true)

    // Elims   
    svg.selectAll("g").data(format.teams)
        .append("text")
        .attr("x", playerWidth - 93)
        .attr("y", (d, i) => i * rowHeight + 35)
        .text(d => d.elims.toString() + " elim points")
        .classed("points", true)

    // Placement points   
    svg.selectAll("g").data(format.teams)
        .append("text")
        .attr("x", playerWidth - 93)
        .attr("y", (d, i) => i * rowHeight + 50)
        .text(d => d.placementPoints.toString() + " place points")
        .classed("points", true)

    svg.selectAll("g").data(format.teams)
        .each(function (teamGames, teamIndex) {
            const g = d3.select(this);
            let totalPoints = 0;
            g
                .selectAll("rect.team-rect")

                .data(teamGames.values)
                .enter()
                .append("rect")
                .attr("x", game => xScale(game.start))
                .attr("y", (d, i) => teamIndex * rowHeight + 7)
                .attr("width", game => xScale(game.end) - xScale(game.start))
                .attr("height", 45)
                .attr("fill", "white")
                .attr("stroke", "black")
                .attr("stroke-width", game => (game.rank === "1") ? 5 : 0)
                .on('click', function (game) {
                    console.log(game.start + " -> " + game.end + "  " + game.secondsAlive);
                })
                .on('mouseover', game => tooltip(svg, game))
                .on('mouseout', function (game) {
                    d3.select(this).attr("stroke-width", game => (game.rank === "1") ? 6 : 1)
                    d3.selectAll(".tooltip").remove();
                })
                .classed("team-rect", true)

                .each(function (game) {
                    const top = 12;
                    const bottom = 33

                    for (let i = 0; i < game.elims; i++) {
                        const xElim = xScale(game.start) + (i * 4) + 7;
                        g // Elim lines
                            .append("line")
                            .attr("x1", xElim)
                            .attr("x2", xElim)
                            .attr("y1", teamIndex * rowHeight + top)
                            .attr("y2", teamIndex * rowHeight + bottom)
                            .attr("stroke-width", "2")
                            .attr("stroke", "darkgrey")
                            .attr("pointer-events", "none");
                    }
                    const elimOffset = game.elims * 4 + 1
                    for (let i = 0; i < game.placementPoints; i++) {
                        const x = xScale(game.start) + (i * 4) + 7 + elimOffset;
                        g // Placement lines
                            .append("line")
                            .attr("x1", x)
                            .attr("x2", x)
                            .attr("y1", teamIndex * rowHeight + top)
                            .attr("y2", teamIndex * rowHeight + bottom)
                            .attr("stroke-width", "2")
                            .attr("stroke", "black")
                            .attr("pointer-events", "none");
                    }
                    const gamePoints = parseInt(game.elims) + parseInt(game.placementPoints);
                    totalPoints += gamePoints;
                    g // Points in game
                        .append("text")
                        .attr("x", xScale(game.start) + 6)
                        .attr("y", teamIndex * rowHeight + 47)
                        .text(gamePoints.toString())
                        .classed("points", true)

                    g // Running total of points
                        .append("text")
                        .attr("x", xScale(game.start) + 70)
                        .attr("y", teamIndex * rowHeight + 47)
                        .text(totalPoints.toString())
                        .classed("points", true)
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

function addSoloRegions(teams) {

    let i = 1;
    function addRegion(region, payout) {
        let team = teams.filter(d => d.key == i.toString())[0];
        team.region = region;
        team.payout = payout;
        team.ordering = i;
        i++;
    }

    addRegion('NA EAST', 3000000); // 1
    addRegion('NA EAST', 1800000);
    addRegion('NA WEST', 1200000);
    addRegion('NA EAST', 1050000);
    addRegion('BRAZIL', 900000);
    addRegion('EUROPE', 600000);
    addRegion('EUROPE', 525000);
    addRegion('EUROPE', 375000);
    addRegion('NA WEST', 300000);
    addRegion('NA EAST', 225000);

    addRegion('NA WEST', 150000); // 11
    addRegion('EUROPE', 150000);
    addRegion('EUROPE', 150000);
    addRegion('EUROPE', 150000);
    addRegion('NA EAST', 150000);
    addRegion('NA WEST', 112500);
    addRegion('EUROPE', 112500);
    addRegion('NA EAST', 112500);
    addRegion('ASIA', 112500);
    addRegion('NA EAST', 112500);

    addRegion('EUROPE', 50000); // 21
    addRegion('EUROPE', 50000);
    addRegion('NA EAST', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);
    addRegion('BRAZIL', 50000);
    addRegion('NA EAST', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);

    addRegion('EUROPE', 50000); // 31
    addRegion('EUROPE', 50000);
    addRegion('ASIA', 50000);
    addRegion('NA WEST', 50000);
    addRegion('NA EAST', 50000);
    addRegion('NA EAST', 50000);
    addRegion('EUROPE', 50000);
    addRegion('NA EAST', 50000);
    addRegion('NA WEST', 50000);
    addRegion('EUROPE', 50000);

    addRegion('EUROPE', 50000); // 41
    addRegion('NA EAST', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);
    addRegion('NA EAST', 50000);

    addRegion('EUROPE', 50000); // 51
    addRegion('BRAZIL', 50000);
    addRegion('NA WEST', 50000);
    addRegion('ASIA', 50000);
    addRegion('ASIA', 50000);
    addRegion('NA EAST', 50000);
    addRegion('BRAZIL', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);
    addRegion('NA EAST', 50000);

    addRegion('NA EAST', 50000); // 61
    addRegion('NA EAST', 50000);
    addRegion('EUROPE', 50000);
    addRegion('NA EAST', 50000);
    addRegion('ASIA', 50000);
    addRegion('EUROPE', 50000);
    addRegion('NA EAST', 50000);
    addRegion('OCEANIA', 50000);
    addRegion('NA EAST', 50000);
    addRegion('NA EAST', 50000);

    addRegion('BRAZIL', 50000); // 71
    addRegion('EUROPE', 50000);
    addRegion('ASIA', 50000);
    addRegion('NA WEST', 50000);
    addRegion('BRAZIL', 50000);
    addRegion('NA EAST', 50000);
    addRegion('NA EAST', 50000);
    addRegion('OCEANIA', 50000);
    addRegion('EUROPE', 50000);
    addRegion('EUROPE', 50000);

    addRegion('EUROPE', 50000); // 81
    addRegion('EUROPE', 50000);
    addRegion('OCEANIA', 50000);
    addRegion('EUROPE', 50000);
    addRegion('NA WEST', 50000);
    addRegion('EUROPE', 50000);
    addRegion('NA EAST', 50000);
    addRegion('EUROPE', 50000);
    addRegion('NA EAST', 50000);
    addRegion('NA EAST', 50000);

    addRegion('ASIA', 50000); // 91
    addRegion('NA EAST', 50000);
    addRegion('NA EAST', 50000);
    addRegion('EUROPE', 50000);
    addRegion('OCEANIA', 50000);
    addRegion('OCEANIA', 50000);
    addRegion('NA WEST', 50000);
    addRegion('BRAZIL', 50000);
    addRegion('NA EAST', 50000);
    addRegion('ASIA', 50000);

}

function addDuoRegions(teams) {

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
    addRegion('NA EAST', 375000);
    addRegion('EUROPE', 225000);
    addRegion('NA EAST', 100000);
    addRegion('EUROPE', 100000); // 10
    addRegion('EUROPE', 100000);
    addRegion('NA WEST', 100000);
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
    addRegion('NA WEST', 100000);
    addRegion('NA WEST', 100000);
    addRegion('BRAZIL', 100000);
    addRegion('OCEANIA', 100000); // 40
    addRegion('NA WEST', 100000);
    addRegion('ASIA', 100000);
    addRegion('NA EAST', 100000);
    addRegion('EUROPE', 100000);
    addRegion('EUROPE', 100000);
    addRegion('NA EAST', 100000);
    addRegion('BRAZIL', 100000);
    addRegion('BRAZIL', 100000);
    addRegion('ASIA', 100000);
    addRegion('OCEANIA', 100000);
};