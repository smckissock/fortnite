import { colors, placementString, text, secondsToString } from "./shared.js";


let matchStart;
let matchEnd;
let notStarted = true;

const cornerRadius = 8;

const chartWidth = 1200 // Not including left margin
const leftMargin = 10;

let regions = [];
let payouts = [];

let regionInfos = [];

let gamesSvg;
let leaderboardSvg;

let regionCursor;

let timeLabel;
let playButton;

let gamesEnded;



let titleText;
let toggleButtonText;

let xScale;


let currentRegion;


const toggleLeft = 626;
const playerWidth = 500;
const rowHeight = 60;

const commaFormat = d3.format(",");

const regionInfo = [
    { color: colors.green, name: "NA EAST", filter: "NA East", textOffset: 5 },
    { color: colors.orange, name: "NA WEST", filter: "NA West", textOffset: 4 },
    { color: colors.blue, name: "EUROPE", filter: "Europe", textOffset: 6 },
    { color: colors.pink, name: "OCEANIA", filter: "Oceania", textOffset: 4 },
    { color: colors.teal, name: "BRAZIL", filter: "Brazil", textOffset: 11 },
    { color: colors.grey, name: "ASIA", filter: "Asia", textOffset: 18 },
    { color: colors.yellow, name: "M. EAST", filter: "Middle East", textOffset: 8 }
];


// Ugh, but this gets here first!
d3.json('ping/data/squad_finals_payout.json').then(function (data) {
    payouts = data;
});


d3.json('ping/data/squad_finals.json').then(function (data) {
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
        rec.region = d.fields[8];

        rec.players = d.players;

        games.push(rec);
    });

    regions = d3.nest()
        .key(d => d.region)
        .entries(games);

    regions.forEach(region =>
        region.teams = d3.nest()
            .key(d => d.placementRank)
            .entries(region.values)
    );

    regions.forEach(function (region) {
        // Attach color
        region.color = regionInfo.find(d => d.filter == region.key).color;
        region.teams.forEach(function (team) {

            // Add team level sum of elims and placement points
            team.elims = d3.sum(team.values, game => game.elims);
            team.placementPoints = d3.sum(team.values, game => game.placementPoints);
            team.games = team.values.length;
            team.averagePlace = d3.sum(team.values, game => game.rank) / team.games;

            team.payout = payouts.find(d => d.region == region.key && team.key == d.rank).payout

            team.player1 = team.values[0].players[0]; 
            team.player2 = team.values[0].players[1];
            team.player3 = team.values[0].players[2];
            team.player4 = team.values[0].players[3];

            // ? 
            let beforeMatch = team.values[0].endSeconds - team.values[0].secondsAlive;

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
        })
    })

    currentRegion = regions[4];  // NA East 

    matchStart = 0;
    matchEnd = 60 * 60 * 4.7;

    xScale = d3.scaleLinear()
        .domain([matchStart, matchEnd])
        .range([playerWidth + leftMargin, playerWidth + leftMargin + chartWidth - 90]);

    let div = d3.select(".timeline");

    leaderboardSvg = div.append("svg")
        .attr("width", chartWidth + leftMargin)
        .attr("height", rowHeight * 100)
        .classed("leaderboard-svg", true);

    // Title, region buttons    
    drawHeader();

    drawGameHeaders();
    drawLeaderboard();
});


function drawHeader() {

    function moveRegionCursor(rectToMoveTo) {
        const x = rectToMoveTo.x.baseVal.value;
        const y = rectToMoveTo.y.baseVal.value;

        regionCursor
            .transition()
            .duration(600)
            .attr("x", x)
            .attr("y", y);
    }


    function drawRegionButtons() {
        const left = 660
        const buttonHeight = 80;
        regionInfo.forEach(function (region, i) {
            svg.append("rect")
                .attr("data", region.filter)
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

                        .attr("stroke-width", 0);
                })
                .on('click', function (d) {
                    let dom = d3.select(this);
                    const region = dom.attr("data");

                    if (region !== currentRegion.key) {
                        showRegion(region);
                        moveRegionCursor(this);
                    }
                })

            svg.append("text")
                .attr("x", left + region.textOffset + (i * 80))
                .attr("y", 30)
                .attr("font-size", "1.2rem")
                .attr("pointer-events", "none")
                .text(region.name)
                .classed("region-name", true)
        }); // End region buttons


        let opacity = 1;

        // Back to Ping button
        const qualifierLeft = 520
        let qualifierButton = svg.append("a")
            .attr("xlink:href", "https://fortniteping.com")
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

        // "Back to"
        svg.append("text")
            .attr("x", qualifierLeft + 19)
            .attr("y", 30)
            .text("Back to")
            .attr("font-family", "Source Sans Pro, sans-serif")
            .attr("font-size", "1.2rem")
            .attr("pointer-events", "none")

        // Fortnite    
        svg.append("text")
            .attr("x", qualifierLeft + 17)
            .attr("y", 50)
            .text("Fortnite")
            .attr("font-family", "Source Sans Pro, sans-serif")
            .attr("font-size", "1.2rem")
            .attr("pointer-events", "none")

        // Ping    
        svg.append("text")
            .attr("x", qualifierLeft + 30)
            .attr("y", 70)
            .text("Ping")
            .attr("font-family", "Source Sans Pro, sans-serif")
            .attr("font-size", "1.2rem")
            .attr("pointer-events", "none")
    }

    const headerHeight = 86;
    let div = d3.select(".title");
    const svg = div.append("svg")
        .attr("width", leftMargin + chartWidth)
        .attr("height", headerHeight);

    text("FORTNITE", svg, "big-fortnite", 20, 55);
    text("ping", svg, "big-ping", 225, 52);

    text("FNCS", svg, "little-ping", 380, 36);
    text("Finals", svg, "little-ping", 375, 68);

    drawRegionButtons();

    // Make this after the the player rects so that always appears "on top"
    regionCursor = svg.append("rect")
        .attr("x", 660)
        .attr("y", 3)
        .attr("width", 70)
        .attr("height", 80)
        .attr("fill", "none")
        .attr("stroke", "black")
        .attr("stroke-width", 6)
        .attr("pointer-events", "none")
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)
}


function showRegion(region) {
    currentRegion = regions.find(d => d.key == region);
    drawGameHeaders();

    d3.selectAll(".leaderboard-team").remove();
    drawLeaderboard();
}

const tickDuration = 20;         // Tick to update clock 
const updateGamesFrequency = 20;  // Update games every x virtual seconds 

let time = Infinity;
let running = false;
let ticker = d3.interval(e => {
    if (running) {
        time += 1; // Seconds in virtual clock
        timeLabel.text(secondsToString(time));  

        if (time % updateGamesFrequency == 0) 
            updateGames(time);
    }

    if (time > matchEnd)
        running = false;
},
tickDuration);

function playGames() {
    if (notStarted) {
        timeLabel.style("opacity", 1.0);
        d3.selectAll(".game-rect").remove();
        notStarted = false;
        time = 240;
    }
    running = true;
}

function updateGames(seconds) {
    //console.log(seconds);
    gameBoxes(seconds);
}

function pauseGames() {
    running = false;
}


function drawLeaderboard() {

    let svg = leaderboardSvg;

    // Big rect for team background 
    svg.selectAll("g").data(currentRegion.teams).enter().append("g")
        .attr("y", function (d, i) {
            let y = i * rowHeight + 3;
            d.y = y;
            return y;
        })
        .classed("leaderboard-team", true)
        .attr("id", d => "n" + d.key.toString())
        .append("rect")
        .attr("x", leftMargin)        
        .attr("y", function (d, i) {
            let y = i * rowHeight + 3;
            d.y = y;
            return y;
        }) 
        .attr("fill", currentRegion.color)
        .attr("width", chartWidth - 3)
        .attr("height", rowHeight - 5)
        .attr("stroke", "black")
        .attr("stroke-width", 0)
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)

    // Labels on the left

    // Rank
    svg.selectAll("g").data(currentRegion.teams).append("text")
        .attr("x", leftMargin + 13)
        .attr("y", (d, i) => i * rowHeight + 31)
        .text(d => "#" + d.key.toString())
        .classed("rank", true)
        .classed("_team-rank", true)

    // Payout    
    svg.selectAll("g").data(currentRegion.teams).append("text")
        .attr("x", leftMargin + 5)
        .attr("y", (d, i) => i * rowHeight + 48)        
        .text(d => "$" + commaFormat(d.payout.toString()))
        .classed("points", true)


    // Players 1 & 2
    const leftPlayer = 66;
    svg.selectAll("g").data(currentRegion.teams).append("text")
        .attr("x", leftMargin + leftPlayer)
        .attr("y", (d, i) => i * rowHeight + 23)        
        .text(d => d.player1 + ", " + d.player2)
        .classed("squad-player", true)

    // Players 3 & 4
    svg.selectAll("g").data(currentRegion.teams).append("text")
        .attr("x", leftMargin + leftPlayer)
        .attr("y", (d, i) => i * rowHeight + 47)       
        .text(d => d.player3 + ", " + d.player3)
        .classed("squad-player", true)

    // Labels just to the right of the player names 

    // Big Points   
    svg.selectAll("g").data(currentRegion.teams).append("text")
        .attr("x", playerWidth - 145)
        .attr("y", (d, i) => i * rowHeight + 33)
        
        .text(d => d.elims + d.placementPoints)
        .classed("rank", true)
        .classed("_team-points", true)

    // "Points" label
    svg.selectAll("g").data(currentRegion.teams).append("text")
        .attr("x", playerWidth - 150)
        .attr("y", (d, i) => i * rowHeight + 49)        
        .text("points")
        .classed("points", true)

    // Elim percentage  
    const fromRight = 100
    const pctFormat = d3.format(",.1%");
    svg.selectAll("g").data(currentRegion.teams).append("text")
        .attr("x", playerWidth - fromRight)     
        .attr("y", (d, i) => i * rowHeight + 19)   
        .text(d => pctFormat(d.elims / (d.elims + d.placementPoints)) + " elim pct")
        .classed("points", true)

    // Elims per game
    svg.selectAll("g").data(currentRegion.teams).append("text")
        .attr("x", playerWidth - fromRight)
        .attr("y", (d, i) => i * rowHeight + 35)        
        .text(d => ((d.elims / d.games).toFixed(1)).toString() + " elims/game")
        .classed("points", true)

    // Average placements   
    svg.selectAll("g").data(currentRegion.teams).append("text")
        .attr("x", playerWidth - fromRight)
        .attr("y", (d, i) => i * rowHeight + 50)       
        .text(d => (d.averagePlace.toFixed(1)).toString() + " avg place")
        .classed("points", true);

    gameBoxes(svg, matchStart);

    notStarted = true;
    updateGames(Infinity);
}


function gameBoxes(time) {

     // Only do anything if a game has ended
     const games = d3.sum(currentRegion.teams, team => team.values.filter(d => d.end < time).length);
     if (games === gamesEnded)
         return;
     gamesEnded = games;
     

    // Update data for new games
    const teams = currentRegion.teams;
    teams.forEach(function(team) {
        team.currentGames = team.values.filter(d => d.end < time);
        team.currentPoints = d3.sum(team.currentGames, d => +d.placementPoints + +d.elims);
        team.currentSort = team.currentPoints * 100 - team.currentGames.length; 
        // Other stats?
    })

    teams.sort((a, b) => b.currentSort - a.currentSort);
    teams.forEach(function(d, i) {d.currentRank = i + 1});

    console.clear();
    console.log("GAMES: " + games)
    console.table(teams);
    
    
    // Draw boxes for each game    
    const svg = leaderboardSvg;
    svg.selectAll(".leaderboard-team").data(currentRegion.teams)
        .each(function (team, teamIndex) {
            
            const teamG = svg.select("#n" + team.key.toString())

            teamG.select("text._team-points").text(team.currentPoints);
            teamG.select("text._team-rank").text("#" + team.currentRank);
                       
            // Draw game boxes for each team in the timespan
            teamG
                .selectAll("rect.game-rect").data(team.currentGames).enter().append("rect")
                .attr("x", game => xScale(game.start))
                .attr("y", 37)
                .attr("y", teamIndex * rowHeight + 8)       
                .attr("width", game => xScale(game.end) - xScale(game.start))
                .attr("height", 45)
                .attr("fill", "white")
                .attr("stroke", "black")
                .attr("stroke-opacity", 1.0)                
                .attr("stroke-width", function (d) {
                    return Math.round(d.placementPoints / 1.5);
                })
                .on('click', function (game) {
                    console.log(game.start + " -> " + game.end + "  " + game.secondsAlive);
                })
                .on('mouseover', game => tooltip(svg, game))
                .on('mouseout', function (game) {
                    //d3.select(this).attr("stroke-width", game => (game.rank === "1") ? 6 : 1)
                    d3.selectAll(".tooltip").remove();
                })
                .classed("game-rect", true)

                // Draw elim lines
                .each(function (game) {
                    // 1st, 2nd...
                    text(placementString(game.rank), teamG, "points", xScale(game.start) + 6, teamIndex * rowHeight + 45).classed("game-rect", true);
                    return;

                    const top = 15;
                    const bottom = 31
                    for (let i = 0; i < game.elims; i++) {
                        const xElim = xScale(game.start) + (i * 6) + 10;
                        teamG // Elim lines
                            .append("line")
                            .attr("x1", xElim)
                            .attr("x2", xElim)                            
                            .attr("y1", teamIndex * rowHeight + top)    
                            .attr("y2", teamIndex * rowHeight + bottom)    
                            .attr("stroke-width", "3")
                            .attr("stroke", "black")
                            .attr("opacity", 1.0)
                            .attr("pointer-events", "none")
                            .classed("game-rect", true);
                    }
                    
                });
        })
        //sortLeaderboard();

        // Resorts team SVGs and updates stats
        function sortLeaderboard() {  
            debugger;
            d3.selectAll(".leaderboard-team")
            .each(function (team, i) {
                const g = d3.select(this);
                            
                //g.select("text._team-points").text(team.points);
                //g.select("text._team-rank").text("#" + (1 + +team.currentRank));
                return;
            
                const curY = team.y;
                //const y = +team.currentRank 
                const toMove = y - curY;
                const y = 0; 
                g
                    .transition()
                    .duration(duration)
                    .style("opacity", "1")
                    .attr("transform", "translate(0," + toMove + ")");
                    //.attr("y", i * rowHeight)  
            });
        } 
    }



function makePlayButton(playGames, pauseGames) {

    let playFunction = playGames;
    let pauseFunction = pauseGames; 

    // "Not Started", "Playing" or "Paused"
    let state = "Not Started";
    
    const click = function() {
        if (state == "Not Started" || state == "Paused") {
            drawPauseSymbol();
            state = "Playing";
            // play();
            console.log(state);
            playFunction();
        } else {
            drawPlaySymbol();
            state = "Paused";
            // pause(); 
            console.log(state);
            pauseFunction();
        }
    }


    function drawPauseSymbol() {   
        d3.selectAll(".play-button").remove();
        
        const pauseTop = 10;   
        const pauseLeft = 27;  
        gamesSvg.append("line")
            .attr("x1", pauseLeft).attr("x2", pauseLeft)
            .attr("y1", pauseTop).attr("y2", pauseTop + 29)
            .classed("pause-button", true);
            
        gamesSvg.append("line")
            .attr("x1", pauseLeft + 16).attr("x2", pauseLeft + 16)
            .attr("y1", pauseTop).attr("y2", pauseTop + 29)
            .classed("pause-button", true);
    }

    function drawPlaySymbol() {
        d3.selectAll(".pause-button").remove();            
     
        var trianglePoints = "22 7, 48 25, 22 41, 22 7";
        gamesSvg.append('polyline')
            .attr('points', trianglePoints)
            .classed("play-button", true);
    }

    const playButton = 
        gamesSvg.append("rect")
            .attr("x", 12)
            .attr("y", 3)
            .attr("width", 46)
            .attr("height", 44)
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .style("fill-opacity", 0)
            .on('click', function (d) {
                let dom = d3.select(this);
                const region = dom.attr("data");
                click();
            })
            .on('mouseover', function (d) {
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 4)
            })
            .on('mouseout', function (d) {
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 0);
            })

        drawPlaySymbol();    
        
        return {
            click: click
        } 
}

function drawGameHeaders() {

    function drawReplayControls() {
        d3.select("#timeLabel").remove();
        timeLabel = text("0:00:00", gamesSvg, "timer", 74, 36, "timeLabel")
        timeLabel.style("opacity", 0);

        playButton = makePlayButton(playGames, pauseGames);
    }

    if (gamesSvg)
        gamesSvg.remove();

    const gameHeaderHeight = 50

    const div = d3.select(".games");
    gamesSvg = div.append("svg")
        .attr("width", chartWidth + leftMargin)
        .attr("height", gameHeaderHeight)
        .classed("games-svg", true);

    const games = [{ num: 1 }, { num: 2 }, { num: 3 }, { num: 4 }, { num: 5 }, { num: 6 }];

    // Add the earliest start and the latest end to each game 
    games.forEach(function (game) {
        game.start = d3.min(currentRegion.teams, d => d.values[game.num - 1] ? d.values[game.num - 1].start : 99999999);
        game.end = d3.max(currentRegion.teams, d => d.values[game.num - 1] ? d.values[game.num - 1].end : 0);
    });

    // Boxes for game headers
    gamesSvg.selectAll("rect").data(games).enter().append("rect")
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

    gamesSvg.selectAll("text.game").data(games).enter().append("text")
        .attr("x", game => xScale(game.start) + 8)
        .attr("y", 18)
        .text(game => "Game " + game.num)
        .classed("game", true);

    function formatSeconds(seconds) {
        return Math.floor(seconds / 60) + ':' + ('0' + Math.floor(seconds % 60)).slice(-2);
    }

    gamesSvg.selectAll("text.game-time").data(games).enter().append("text")
        .attr("x", game => xScale(game.start) + 8)
        .attr("y", 34)
        .text(game => formatSeconds(game.end - game.start))
        .classed("game-time", true)
    //.attr("class", d => "game-time-" + d.num);

    drawReplayControls();
}


// Not called. Supposed to transition the x and width of the game rectangles 
/* function updateGameHeaders() {

    function formatSeconds(seconds) {
        return Math.floor(seconds / 60) + ':' + ('0' + Math.floor(seconds % 60)).slice(-2);
    }

    const games = [{ num: 1 }, { num: 2 }, { num: 3 }, { num: 4 }, { num: 5 }, { num: 6 }];

    games.forEach(function (game) {
        game.start = d3.min(currentRegion.teams, d => d.values[game.num - 1] ? d.values[game.num - 1].start : 99999999);
        game.end = d3.max(currentRegion.teams, d => d.values[game.num - 1] ? d.values[game.num - 1].end : 0);
    });

    console.log(currentRegion.teams.length);
    console.log("");
    games.forEach(function (game) {
        const x = xScale(game.start);
        const width = xScale(game.end) - xScale(game.start) + 40;

        console.log(".game" + game.num + " " + x);
        const rect = d3.select(".game" + game.num);

        rect
            .transition()
            .duration(1000)
            .attr("width", width)
            .attr("x", x)

        const time = d3.select(".game-time-" + game.num);
        time.text = formatSeconds(game.end - game.start);
    });
}
 */



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