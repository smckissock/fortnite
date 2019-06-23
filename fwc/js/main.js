'use strict';

let playerDim;
let playerStatsGroup;

const LeftSideWidth = 340;
let PlayerTableWidth = 240 + (9 * 80); // Player + other cols

let playerColors;

let theWeekChart; 

let facts;

let selectedPlayerNode;

// Function that weekChart sets and personChart calls!! 
let showPlayerOnWeekChart;
// Function that playerChart sets and regionChart, weekChart and filter calls 
let clearPlayer;


let soloQualifications = [];
let duoQualifications = [];

const cornerRadius = 8;


let titleSvg;

let filterTextDisplayed;



const green ='#319236';
const purple = '#9D4DBB';
const blue = '#4C51F7';
const red = '#DB4441';
const teal = '#3E93BC';
const lime = '#3CFF3E';
const grey = '#B3B3B3';
//const brown = '#8B4513';
const brown = '#987654';


let filters = {
    week: "",
    regions: [],
    search: "",
    player: "",
    sort: "payout",
    soloOrDuo: "",
    page: 0,
    playerCount: 0
}


d3.json('fwc/data/data.json').then(function (data)  {
    const leftMargin = 20
    const screenWidth = LeftSideWidth + PlayerTableWidth - leftMargin;
    titleSvg = title(screenWidth);
    searchLabel(titleSvg);
    posickLabel(titleSvg)
    disclaimer(titleSvg);
    
    data.forEach(function (d) {
        d.rank = +d.rank;
        d.payout = +d.payout;
        d.points = +d.points;
    });
    makeQualifications(data); 

    facts = crossfilter(data);
    draw(facts);
    downloadButton(titleSvg, screenWidth);  // 730
    helpButton(titleSvg, screenWidth);  // 730
    filtersAndCount(titleSvg, screenWidth);

    d3.select("#search-input").on('keyup', function (event) {
        // Regardless of what happens below, selected player needs to be cleared 
        filters.player = "";
        showPlayerOnWeekChart();

        const searchTerm = document.getElementById("search-input").value;
        
        filters.search = searchTerm; 
        playerDim.filter(function (d) { 
            return d.toLowerCase().indexOf(searchTerm.toLowerCase()) !== -1;
        });
                
        dc.redrawAll();
    });
    updateCounts();
});


d3.csv('fwc/data/data.csv').then(function (data)  {
});


function makeQualifications(data) {
    data.forEach(function (placement) {
        if (placement.soloQual != 0) 
            soloQualifications.push({player: placement.player, week: placement.week.replace("Week ", "")});

        if (placement.duoQual != 0)
            //duoQualifications.push(placement.player);
            duoQualifications.push({player: placement.player, week: placement.week.replace("Week ", "")});
    });
}

// Big Fortnite title
function title(width) {
    const div = d3.select(".title");
    const svg = div.append("svg")
        .attr("width", width + "px")
        .attr("height", "80px");
    
    svg.append("text")
        .attr("x", 0)
        .attr("y", 65)
        .text("FORTNITE  World Cup Stats")
        .attr("font-size", "1.1em")
        .attr("fill", "black"); 
    
    return svg;
}



function posickLabel(svg) {
    svg.append("text")
        .attr("x", 565)
        .attr("y", 33)
        .text('Support this using creator code "Posick" !')
        .attr("font-size", ".9rem")
        .attr("fill", "black")
        .style("font-family", "Helvetica, Arial, sans-serif")
        .attr("font-weight", 800) 
}

function searchLabel(svg) {
    svg.append("text")
        .attr("x", 565)
        .attr("y", 72)
        .text("Search")
        .attr("font-size", "1.4rem")
        .attr("fill", "black")
        .attr("font-weight", 400)
}

function disclaimer(svg) {
    svg.append("text")
        .attr("x", 956)
        .attr("y", 34)
        .text("Top 100 in each region for each week")
        .attr("font-size", ".8rem")
        .attr("fill", "#606060")
        .style("font-family", "Helvetica, Arial, sans-serif")
        .attr("font-weight", 400) 
}

function filtersAndCount(svg, screenWidth) {
    svg.append("text")
        .attr("x", screenWidth - 540)
        .attr("y", 70)
        .text("")
        .attr("font-size", "1.0rem")
        .attr("fill", "black")
        .attr("pointer-events", "none")
        .attr("id", "filterText1"); 

    svg.append("text")
        .attr("x", screenWidth - 540)
        .attr("y", 70)
        .text("")
        .attr("font-size", "1.1rem")
        .attr("fill", "black")
        .attr("pointer-events", "none")
        .attr("id", "filterText2"); 
}

function helpButton(svg, screenWidth) {
    
    svg.append("circle")
        .attr("cx", screenWidth - 30)
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
            window.open('help.html', '_blank');    
        });
        
    svg.append("text")
        .attr("x", screenWidth - 37)
        .attr("y", 59)
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
            window.open('help.html', '_blank');    
        });

        // Arrow: center line 
        var line = svg.append("line")
             .attr("x1",screenWidth - helpButtonWidth + 0)  
             .attr("y1", 35)  
             .attr("x2",screenWidth - helpButtonWidth + 0)  
             .attr("y2", 57)  
             .classed("download-arrow", true);

        // Arrow: left line      
        var line = svg.append("line")
             .attr("x1",screenWidth - helpButtonWidth - 10)  
             .attr("y1", 48)  
             .attr("x2",screenWidth - helpButtonWidth + 2)  
             .attr("y2", 58)  
             .classed("download-arrow", true);

        // Arrow: right line      
        var line = svg.append("line")
             .attr("x1",screenWidth - helpButtonWidth + 10)  
             .attr("y1", 48)  
             .attr("x2",screenWidth - helpButtonWidth - 2)  
             .attr("y2", 58)  
             .classed("download-arrow", true);
}


// Makes the string that displayse number of players and filters  
function updateCounts() {
    makePlayerStatsGroup(playerDim);

    let filterText = "";
    
    // if player is selected, just show player, otherwise show all the filters
    if (filters.player != "") {
        filterText = filters.player;
    } else {
        let filterParts = [];
        
        //if (filters.region != "")
        //    filterParts.push(filters.region);

        if (filters.regions.length != 0)
            filterParts.push(filters.regions.join(", "));

        //if (filters.week != "")
        //    filterParts.push(filters.week);
        if (filters.soloOrDuo != "")
            filterParts.push(filters.soloOrDuo);
        else
            if (filters.week != "")
                filterParts.push(filters.week);

        if (filters.search != "")
            filterParts.push('"' + filters.search + '"'); 
        
        const num = d3.format(",d"); // Add commas
        filterParts.push(num(filters.playerCount) + " players")
        filterText = filterParts.join(" / ");

        let sort = filters.sort.charAt(0).toUpperCase() + filters.sort.slice(1);
        switch(filters.sort) {
            case "earnedQualifications": sort = "Earned Quals"; break; 
            case "elims": sort = "Elim Points"; break;
            case "elimPercentage": sort = "Elim %"; break;
            case "placementPoints": sort = "Placement Points"; break;
            case "placementPercentage": sort = "Placement %"; break;
        }
        filterText += " by " + sort; 
    }

    // Toggle the filter to display, then fade it in and fade the old one out
    filterTextDisplayed = (filterTextDisplayed === "#filterText1") ? "#filterText2" : "#filterText1";
    titleSvg.select(filterTextDisplayed)
        .transition()
        .duration(300)
        .text(filterText)
        .attr("fill-opacity", 1.0);
    titleSvg.select((filterTextDisplayed === "#filterText2") ? "#filterText1" : "#filterText2")
        .transition()
        .duration(400)
        .attr("fill-opacity", 0);
}

function draw(facts) {
    playerDim = facts.dimension(dc.pluck("player"));
    makePlayerColors();

    makePlayerStatsGroup(playerDim);

    const dim = facts.dimension(dc.pluck("region"));
    const group = dim.group().reduceSum(dc.pluck("payout"));

    const weekDim = facts.dimension(dc.pluck("week"));
    const weekPayoutGroup = weekDim.group().reduceSum(dc.pluck("payout"));

    weekChart("#chart-weeks")
        .dimension(weekDim)
        .group(weekPayoutGroup);      
        
    regionChart("#chart-region")
        .dimension(dim)
        .group(group);
        
    let players = playerChart("#chart-player")
        .dimension(playerStatsGroup); 

    dc.registerChart(players, null);

    dc.renderAll();
    //updateCounts();
}

function makePlayerColors() {
    playerColors = {};
    playerDim.top(Infinity).forEach(function (d) {
        playerColors[d.player] =  getColorForRegion(d.region);
    });
}

function getColorForRegion(region) {
    switch (region) {
        case "NA West": return "purple"; break;
        case "NA East": return "green"; break;
        case "Europe": return "blue"; break;
        case "Oceania": return "red"; break;
        case "Asia": return "brown"; break;
        case "Brazil": return "teal"; break;
    }  
}

function makePlayerStatsGroup() {
    playerStatsGroup =  

    playerDim.group().reduce(
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
            p.earnedQualifications = p.earnedQualifications + v.earnedQualifications
            return p;
        },
        function (p, v) {
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
            p.earnedQualifications = p.earnedQualifications - v.earnedQualifications;

            return p;
        },
        function (p) {
            return {   
                soloQual:0
                , duoQual: 0 

                , rank: 0
                , payout: 0
                , points: 0
                , wins: 0
                , elims: 0
                , elimPercentage: 0
                , placementPoints: 0
                , placementPercentage: 0
                , earnedQualifications: 0 
            };
        }
    );
}