
import { colors, setupStats, text } from "./shared.js";
import { playerChart, playerData, PlayerTableWidth } from "./playerChart.js";
import { eventChart } from "./eventChart.js";
import { regionChart } from "./regionChart.js";
import { teamChart, clearTeam } from "./teamChart.js";


export const cornerRadius = 0;
export let playerColors;
export let playerDim;

export let soloQualifications = [];
export let duoQualifications = [];
export let qualifierNames = {};

export let teamMembers = [];

export let data;
export let facts;

export let filters = {
    weeks: [],
    regions: [],
    team: "",
    search: "",
    player: "",
    sort: "powerPoints",
    //sort: "payout",
    soloOrDuo: "",
    page: 0,
    playerCount: 0,
    worldCupOnly: false,
    // For scatter plots
    xMeasure: {},
    yMeasure: {}
}

const regions = [
    { id: 3, name: "NA East" },
    { id: 4, name: "NA West" },
    { id: 5, name: "Europe" },
    { id: 2, name: "Oceania" },
    { id: 6, name: "Brazil" },
    { id: 7, name: "Asia" },
    { id: 8, name: "Middle East" }
];


export let statsForPlayer;
export let playerInfos = [];

let playerStatsGroup;

const LeftSideWidth = 340;

let titleSvg;
let filtersSvg;
let filterTextDisplayed;

let loadingSvg;
let events;

function makeLoadingSvg() {
    loadingSvg = d3.select("div.grid.gradient")
        .append("svg");

    loadingSvg.append("circle")
        .attr("cx", 500)
        .attr("cy", 500)
        .attr("r", 200)
        .attr("fill", "white")
        .attr("stroke", "black")
}


d3.json('ping/data/dimensions.json').then(function (dimensions) {
    playerInfos = [];
    dimensions.players.forEach(function (d) {
        let rec = {};
        rec.id = d[0];
        rec.name = d[1];
        rec.nationality = d[2];
        rec.team = d[3];
        rec.age = d[4];
        rec.championSeriesAvg = d[5];
        rec.regionId = d[6];
        playerInfos.push(rec);
    });

    const weeks = dimensions.weekWeights;
    events = dimensions.events;
    
    // Assign power ranking weight to each event based on week  
    events.forEach(function (e) {
        e.weight = weeks.find(w => w.Id === e.weekId).Weight;
    })
});

d3.json('ping/data/data.json').then(function (dataArray) {
    const leftMargin = 20

    // From playerChart!!!
    const playerTableWidth = 964;
    const teamWidth = 180;

    //const screenWidth = LeftSideWidth + teamWidth + playerTableWidth - leftMargin;
    const screenWidth = 1920 - leftMargin;
    titleSvg = title(screenWidth);
    faqButton(titleSvg);
    mostSearchedButton(titleSvg);

    //searchLabel(titleSvg);
    //posickLabel(titleSvg);
    //disclaimer(titleSvg);

    data = [];
    var begin = new Date();
    dataArray.forEach(function (d) {
        let rec = {};
        rec.soloQual = parseInt(d[0], 10);
        rec.duoQual = parseInt(d[1], 10);
        rec.soloOrDuo = d[2];
        rec.player = d[3];
        //rec.region = d[4];
        rec.region = regions.find(r => r.id == d[4]).name;
        rec.nationality = d[5];
        rec.team = d[6];
        rec.rank = parseInt(d[7], 10);
        rec.payout = parseInt(d[8], 10);
        rec.points = parseInt(d[9], 10);
        rec.wins = parseInt(d[10], 10);
        rec.elims = parseInt(d[11], 10);
        rec.placementPoints = parseInt(d[12], 10);
        rec.earnedQualifications = parseInt(d[13], 10);
        rec.rawPowerPoints = Math.round(parseInt(d[14], 10));
        rec.eventPlayerName = d[15];
        rec.playerId = parseInt(d[16], 10);
       
        const event = events.find(e => e.id === parseInt(d[17], 10));
        rec.week = event.name;
        rec.weight = +event.weight;
        rec.weight = rec.weight + .08; // Change this each week!!

        rec.powerPoints = Math.round(rec.rawPowerPoints * rec.weight);

        data.push(rec);
    });
    var end = new Date();
    console.log("Setup placements " + (end - begin) + " ms"); 

    
    statsForPlayer = setupStats(data);

    makeQualifications(data);
    makeTeamMembers(data);

    facts = crossfilter(data);

    d3.select("#root")
        .classed("loader", false);
    d3.select("#right")
        .style("display", "block");    

    draw(facts);

    d3.select("#search-input").on('keyup', function (event) {
        // Regardless of what happens below, selected player needs to be cleared 
        filters.player = "";

        clearTeam();

        const searchTerm = document.getElementById("search-input").value;

        filters.search = searchTerm;
        playerDim.filter(function (d) {
            return d.toLowerCase().indexOf(searchTerm.toLowerCase()) !== -1;
        });

        dc.redrawAll();
    });
    updateCounts();

    // So the search box once everything is loaded
    d3.select("#search-input")
        .style("visibility", "visible");
    
});


function makeQualifications(data) {
    data.forEach(function (placement) {
        if (placement.soloQual != 0) {
            soloQualifications.push({ player: placement.player, week: placement.week.replace("WC Week ", "") });
            qualifierNames[placement.player] = "";
            return;
        }
        if (placement.duoQual != 0) {
            duoQualifications.push({ player: placement.player, week: placement.week.replace("WC Week ", "") });
            qualifierNames[placement.player] = "";
            return;
        }
    });
}

function makeTeamMembers(data) {

    const members = data.filter(d => (d.team != '') && (d.team != 'Free Agent'))

    let finder = function (d) { return d.team; }
    members.forEach(function (d) {
        // Get the team, or add if it is not there
        let idx = teamMembers.findIndex(d2 => d.team == d2.team);
        let team = {}
        if (idx == -1) {
            // Add a new team
            team = { team: d.team, players: [] }
            teamMembers.push(team);
        } else {
            team = teamMembers[idx];
        }

        // Now add player to team
        idx = team.players.findIndex(d2 => d.player == d2);
        if (idx == -1)
            team.players.push(d.player);
    });
}

// Big Fortnite title
function title(width) {
    const div = d3.select(".title");
    const svg = div.append("svg")
        .attr("width", width + "px")
        .attr("height", "100px");

    text("FORTNITE", svg, "big-fortnite", 0, 55);
    text("ping", svg, "big-ping", 205, 52);

    svg.append("text")
        .attr("x", 0)
        .attr("y", 82)
        .text("Competitive Battle Royale Stats")
        .attr("font-size", ".4em")
        .attr("letter-spacing", ".1rem")
        .attr("font-weight", "900")
        .style("font-family", "Source Sans Pro, sans-serif")
        .attr("fill", "black");

    return svg;
}


function faqButton(svg) {
    const left = 890;
    let qualifierButton = svg.append("a")
        //.attr("xlink:href", "https://fortnitewc.netlify.com/finals.html")        
        .append("rect")
        .attr("x", left)
        .attr("y", 10)
        .attr("width", 70)
        .attr("height", 70)
        .attr("fill", "lightblue")
        .attr("stroke", "black")
        .attr("stroke-width", 0)
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)
        .on('mouseover', function (d) {
            d3.select(this)
                .transition()
                .duration(100)
                .attr("stroke-width", 5);
        })
        .on('mouseout', function (d) {
            d3.select(this)
                .transition()
                .duration(100)
                .attr("stroke-width", 0);
        })
        .on('click', function (d) {
            window.open('r/power-ranking-faq', '_blank');
            //window.open('faq.html', '_blank');
        });

    text("Power", svg, "button-text", left + 12, 32);  
    text("Ranking", svg, "button-text", left + 5, 51);  
    text("FAQ", svg, "button-text", left + 20, 70);    
} 

function mostSearchedButton(svg) {
    const qualifierLeft = 810;
    let qualifierButton = svg.append("a")
        //.attr("xlink:href", "https://fortnitewc.netlify.com/finals.html")        
        .append("rect")
        .attr("x", qualifierLeft)
        .attr("y", 10)
        .attr("width", 70)
        .attr("height", 70)
        .attr("fill", "lightblue")
        .attr("stroke", "black")
        .attr("stroke-width", 0)
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)
        .on('mouseover', function (d) {
            d3.select(this)
                .transition()
                .duration(100)
                .attr("stroke-width", 5);
        })
        .on('mouseout', function (d) {
            d3.select(this)
                .transition()
                .duration(100)
                .attr("stroke-width", 0);
        })
        .on('click', function (d) {
            window.open('r/player-search', '_blank');
        });

    text("Most", svg, "button-text", qualifierLeft + 18, 32);  
    text("Searched", svg, "button-text", qualifierLeft + 1, 51);  
    text("Players", svg, "button-text", qualifierLeft + 9, 70);    
} 


function posickLabel(svg) {
    const left = 460
    text("Use code", svg, "posick", left - 50, 43);
    text('"Posick"', svg, "posick", left - 50, 72);
}

function searchLabel(svg) {
    svg.append("text")
        .attr("x", 756)
        .attr("y", 71)
        .text("Search")
        .style("font-family", "Helvetica, Arial, sans-serif")
        .attr("font-size", "1.0rem")
        .attr("fill", "black")
        .attr("font-weight", 600)
}

function disclaimer(svg) {
    return;
    svg.append("text")
        .attr("x", 1190)
        .attr("y", 34)
        .text("2019 World Cup earnings")
        //.text("Top 100 in each region for each week")
        .attr("font-size", ".9rem")
        .attr("fill", "#606060")
        .style("font-family", "Helvetica, Arial, sans-serif")
        .attr("font-weight", 400)
}

function filtersAndCount() {
    const height = 34;

    const div = d3.select(".filters");
    filtersSvg = div.append("svg")
        .attr("width", "800px")
        .attr("height", "50px");
    
    text("", filtersSvg, "filters-string", 10, height, "filterText1");  
    text("", filtersSvg, "filters-string", 10, height, "filterText2"); 
}

function helpButton(svg, screenWidth) {

    const y = 46
    svg.append("circle")
        .attr("cx", screenWidth - 20)
        .attr("cy", y)
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
            window.open('help.html', '_blank');
        });

    svg.append("text")
        .attr("x", screenWidth - 28)
        .attr("y", y + 12)
        .text("?")
        .attr("font-size", ".7em")
        .attr("fill", "black")
        .attr("pointer-events", "none");
}

function downloadButton(svg, screenWidth) {
    const helpButtonWidth = 82;
    svg.append("circle")
        .attr("cx", screenWidth - helpButtonWidth)
        .attr("cy", 46)
        .attr("r", 22)
        .attr("fill", "lightblue")
        .attr("stroke", "black")
        .attr("stroke-width", 0)
        .on('mouseover', function (d) {
            d3.select(this)
                .transition()
                .duration(50)
                .attr("stroke-width", 4)
        })
        .on('mouseout', function (d) {
            d3.select(this)
                .transition()
                .duration(50)
                .attr("stroke-width", 0);
        })
        .on('click', function (d) {
            downloadCsv();
        });

    // Arrow: center line 
    svg.append("line")
        .attr("x1", screenWidth - helpButtonWidth + 0)
        .attr("y1", 35)
        .attr("x2", screenWidth - helpButtonWidth + 0)
        .attr("y2", 57)
        .classed("download-arrow", true);

    // Arrow: left line      
    svg.append("line")
        .attr("x1", screenWidth - helpButtonWidth - 10)
        .attr("y1", 48)
        .attr("x2", screenWidth - helpButtonWidth + 2)
        .attr("y2", 58)
        .classed("download-arrow", true);

    // Arrow: right line      
    svg.append("line")
        .attr("x1", screenWidth - helpButtonWidth + 10)
        .attr("y1", 48)
        .attr("x2", screenWidth - helpButtonWidth - 2)
        .attr("y2", 58)
        .classed("download-arrow", true);
}


// Makes the string that displays number of players and filters  
export function updateCounts() {

    makePlayerStatsGroup(playerDim);

    let filterText = "";

    // If player is selected, just show player, otherwise show all the filters
    if (filters.player != "") {
        filterText = filters.player;
    } else {
        let filterParts = [];

        if (filters.team != "")
            filterParts.push(filters.team);

        // Don't want to show "All" which is the region used for World Cup    
        if (filters.regions.length != 0)
            filterParts.push(filters.regions.join(", "));

        if (filters.soloOrDuo != "")
            filterParts.push(filters.soloOrDuo);
        else
            if (filters.weeks.length != 0)
                filterParts.push(filters.weeks.join(", "));
        
        if (filters.search != "")
            filterParts.push('"' + filters.search + '"');

        const num = d3.format(",d"); // Add commas
        filterParts.push(num(filters.playerCount) + ((filters.worldCupOnly) ? " WC qualifiers" : " players"));

        filterText = filterParts.join(" / ");

        filterText += " by " + niceSortName();
    }

    // Toggle the filter to display, then fade it in and fade the old one out
    filterTextDisplayed = (filterTextDisplayed === "#filterText1") ? "#filterText2" : "#filterText1";
    filtersSvg.select(filterTextDisplayed)
        .transition()
        .duration(300)
        .text(filterText)
        .attr("fill-opacity", 1.0);
    filtersSvg.select((filterTextDisplayed === "#filterText2") ? "#filterText1" : "#filterText2")
        .transition()
        .duration(400)
        .attr("fill-opacity", 0); 
}

function niceSortName() {
    let sort = filters.sort.charAt(0).toUpperCase() + filters.sort.slice(1);
    switch (filters.sort) {
        case "earnedQualifications": sort = "Earned Quals"; break;
        case "elims": sort = "Elim Points"; break;
        case "elimPercentage": sort = "Elim %"; break;
        case "placementPoints": sort = "Placement Points"; break;
        case "placementPercentage": sort = "Placement %"; break;
        case "powerPoints": sort = "Power Ranking"; break;
    }
    return sort;
}


function draw(facts) {
    playerDim = facts.dimension(dc.pluck("player"));
    makePlayerColors();

    makePlayerStatsGroup(playerDim);

    const dim = facts.dimension(dc.pluck("region"));
    const group = dim.group().reduceSum(dc.pluck("payout"));

    const weekDim = facts.dimension(dc.pluck("week"));
    const weekPayoutGroup = weekDim.group().reduceSum(dc.pluck("payout"));

    eventChart("#chart-event")
        .dimension(weekDim)
        .group(weekPayoutGroup);

    regionChart("#chart-region")
        .dimension(dim)
        .group(group);


    var teamDim = facts.dimension(dc.pluck("team"));
    var teamGroup = teamDim.group().reduceSum(dc.pluck("payout"));

    // Hide for now. Also re-register below
    let team = teamChart("#chart-team", teamDim, teamGroup)
        .dimension(teamDim)
        .group(teamGroup);

    let players = playerChart("#chart-player")
        .dimension(playerStatsGroup);

    const width = 1464;
    //downloadButton(titleSvg, width);
    helpButton(titleSvg, width - 50 - 400); // 200 for teams

    filtersAndCount();

    dc.registerChart(players, null);
    //  dc.registerChart(team, null);

    dc.renderAll();
}

function makePlayerColors() {
    playerColors = {};
    playerDim.top(Infinity).forEach(function (d) {
        const color = getColorForRegion(d.region);
        if (color !== "NONE")
            playerColors[d.player] = color;
    });
}

function getColorForRegion(region) {
    switch (region) {
        case "NA West": return colors.orange; break;
        case "NA East": return colors.green; break;
        case "Europe": return colors.blue; break;
        case "Oceania": return colors.pink; break;
        case "Asia": return colors.yellow; break;
        case "Brazil": return colors.teal; break;
        case "Middle East": return colors.grey; break;
    }
    // This was passed "ALL" for region 
    return "NONE";
}

function makePlayerStatsGroup() {

    function GetPlayer() {
        return 9;
    }

    playerStatsGroup =
        playerDim.group().reduce(
            // Add
            function (p, v) {
                p.soloQual = p.soloQual + v.soloQual;
                p.duoQual = p.duoQual + v.duoQual;

                p.rank = p.rank + v.rank;
                p.payout = p.payout + v.payout;
                p.points = p.points + v.points;
                p.wins = p.wins + v.wins;
                p.elims = p.elims + v.elims;
                p.elimPercentage = p.elims / p.points;
                p.placementPoints = p.placementPoints + v.placementPoints;
                p.placementPercentage = p.placementPoints / p.points;
                p.earnedQualifications = 4;
                p.powerPoints = p.powerPoints + v.powerPoints;
                return p;
            },
            // Remove
            function (p, v) {
                //console.log(v);
                p.soloQual = p.soloQual - v.soloQual;
                p.duoQual = p.duoQual - v.duoQual;

                p.rank = p.rank - v.rank;
                p.payout = p.payout - v.payout;
                p.points = p.points - v.points;
                p.wins = p.wins - v.wins;
                p.elims = p.elims - v.elims;
                p.elimPercentage = p.elims / p.points;
                p.placementPoints = p.placementPoints - v.placementPoints;
                p.placementPercentage = p.placementPoints / p.points;
                p.earnedQualifications = 4;
                p.powerPoints = p.powerPoints - v.powerPoints;

                return p;
            },
            // Default
            function (p, v) {
                //console.log(v);
                return {
                    soloQual: 0
                    , duoQual: 0

                    , rank: 0
                    , payout: 0
                    , points: 0
                    , wins: 0
                    , elims: 0
                    , elimPercentage: 0
                    , placementPoints: 0
                    , placementPercentage: 0
                    , earnedQualifications: GetPlayer()
                    , powerPoints: 0 
                };
            }
        );
}



function makeCsv() {
    const data = playerData;

    const columnDelimiter = ',';
    const lineDelimiter = '\n';

    const columns = [
        { name: "Player", field: "key" },

        { name: "Payout", field: "payout" },
        { name: "Points", field: "points" },
        { name: "Rank", field: "rank" },
        { name: "Wins", field: "Wins" },
        { name: "Earned Quals", field: "earnedQualifications" },
        { name: "Elimination Points", field: "elims" },
        { name: "Elim %", field: "elimPercentage" },
        { name: "Placement Points", field: "placementPoints" },
        { name: "Placement %", field: "placementPercentage" },
        { name: "Solo Qualification Week", field: "soloQual" },
        { name: "Duo Qualification Week", field: "duoQual" },
        // These aren't included in data...
        /* {name: "Team", field: "team"},
        {name: "Nationality", field: "nationality"}, */
    ];

    const colHeaders = columns.map(x => x.name);
    const headerRow = colHeaders.join(columnDelimiter);

    let rows = [];
    rows.push(headerRow);

    data.forEach(function (row) {
        let line = [];

        // Add player name
        line.push(row.key);

        // Add regular fields
        columns.slice(1).forEach(field => line.push(row.values[0].value[field.field]));

        rows.push(line.join(columnDelimiter));
    });

    return rows.join(lineDelimiter);
}


function downloadCsv() {

    function fileName() {
        let parts = [];

        parts.push("Fortnite World Cup");

        if (filters.regions.length > 0)
            parts.push(filters.regions.join(" "));

        if (filters.soloOrDuo != "")
            parts.push(filters.soloOrDuo);
        else
            if (filters.week != "")
                parts.push(filters.week);

        if (filters.search != "")
            parts.push('"' + filters.search + '"');

        parts.push("by " + niceSortName());

        return parts.join(" ") + ".csv";
    }

    let csv = makeCsv();

    if (!csv.match(/^data:text\/csv/i))
        csv = 'data:text/csv;charset=utf-8,' + csv;

    const data = encodeURI(csv);

    const link = document.createElement('a');
    link.setAttribute('href', data);
    link.setAttribute('download', fileName());
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

