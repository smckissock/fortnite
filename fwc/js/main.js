'use strict';

let playerDim;
let playerStatsGroup;

const LeftSideWidth = 340;
let PlayerTableWidth = 240 + (5 * 80); // Player + other cols

let playerColors;

let theWeekChart; 

let facts;

let selectedPlayerNode;

// Function that weekChart sets and personChart calls!! 
let showPlayerOnWeekChart;
// Function that playerChart sets and regionChart, weekChart and filter calls 
let clearPlayer;

const green ='#319236';
const purple = '#9D4DBB';
const blue = '#4C51F7';
const red = '#DB4441';
const teal = '#3E93BC';
const lime = '#3CFF3E';
const grey = '#B3B3B3';
const brown = '#8B4513';


let filters = {
    week: "",
    region: "",
    search: "",
    player: "",
    sort: "payout",
    page: 0,
    playerCount: 0
}


d3.json('fwc/data/data.json').then(function (data)  {
    const leftMargin = 20
    const screenWidth = LeftSideWidth + PlayerTableWidth - leftMargin;
    let titleSvg = title(screenWidth);
    
    data.forEach(function (d) {
        d.rank = +d.rank;
        d.payout = +d.payout;
        d.points = d.points;
    });
    facts = crossfilter(data);
    draw(facts);
    helpButton(titleSvg, screenWidth);  // 730

    d3.select("#search-input").on('keyup', function (event) {
        // Regardless of what happens below, selected player needs to be cleared 
        filters.player = "";
        showPlayerOnWeekChart();

        const searchTerm = document.getElementById("search-input").value;
        
        filters.search = searchTerm; 
        playerDim.filter(function (d) { 
            return d.toLowerCase().indexOf(searchTerm.toLowerCase()) !== -1;
        });
        
        updateCounts();
        dc.redrawAll();
    });
});


function title(width) {
    const div = d3.select(".title");
    const svg = div.append("svg")
        .attr("width", width + "px")
        .attr("height", "70px");
    
    svg.append("text")
        .attr("x", 0)
        .attr("y", 65)
        .text("FORTNITE  World Cup Stats")
        .attr("font-size", "1.1em")
        .attr("fill", "black"); 
    
    return svg;
}

function helpButton(svg, screenWidth) {
    
    svg.append("circle")
        .attr("cx", screenWidth - 30)
        .attr("cy", 46)
        .attr("r", 22)
        .attr("fill", "green")
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
        .attr("x", screenWidth - 38)
        .attr("y", 61)
        .text("?")
        .attr("font-size", ".7em")
        .attr("fill", "black")
        .attr("pointer-events", "none");     
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
        
        if (filters.region != "")
            filterParts.push(filters.region);
        if (filters.week != "")
            filterParts.push(filters.week);
        if (filters.search != "")
            filterParts.push('"' + filters.search + '"'); 
        
        const num = d3.format(",d"); // Add commas
        filterParts.push(num(filters.playerCount) + " players")

        filterText = filterParts.join(" / ");
        filterText += " by " +  filters.sort.charAt(0).toUpperCase() + filters.sort.slice(1); 
    }
        
    d3.select("#count-box")
        .text(" " + filterText);
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

    //players._doRedraw();
    dc.registerChart(players, null);

    dc.renderAll();
    updateCounts();
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
        case "Oceana": return "red"; break;
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
            p.placementPoints = p.placementPoints + v.placementPoints;
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
            p.placementPoints = p.placementPoints - v.placementPoints;
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
                , placementPoints: 0
            };
        }
    );
}