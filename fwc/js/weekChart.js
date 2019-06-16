"use strict"


function weekChart(id) {

    const weeks = [
        {num: 1, name: "Week 1", type:"Solo", done: true},
        {num: 2, name: "Week 2", type:"Duo", done: true},
        {num: 3, name: "Week 3", type:"Solo", done: true},
        {num: 4, name: "Week 4", type:"Duo", done: true},
        {num: 5, name: "Week 5", type:"Solo", done: true},
        {num: 6, name: "Week 6", type:"Duo", done: true},
        {num: 7, name: "Week 7", type:"Solo", done: true},
        {num: 8, name: "Week 8", type:"Duo", done: true},
        {num: 9, name: "Week 9", type:"Solo", done: true},
        {num: 10, name: "Week 10", type:"Duo", done: false},
    ];

    let weekSelections = [];
    let stars = [];

    const soloX = 10;
    const duoX = 155; 

    const width = 135;
    const height = 105;
    const strokeWidthThick = 11;
    const strokeWidthThin = 4; 

    const bigLabel = {x: 25, y: 59, size: "2em" };  //49
    const smallLabel = {x: 40, y: 24, size: "1.2em" }; // 20

    const col1 = 9; 
    const placeLabelPos = {x: col1, y: 41, size: ".9em" }; 
    const moneyLabelPos = {x: col1, y: 55, size: ".7em" }; 
    const elimsLabelPos = {x: col1, y: 70, size: ".7em" };    
    const placementLabelPos = {x: col1, y: 85, size: ".7em" };
    
    const col2 = 65;
    const pointsLabelPos = {x: col2, y: 41, size: ".7em" };
    const winsLabelPos = {x: col2, y: 55, size: ".7em" };  
    const elimPercentLabelPos = {x: col2, y: 70, size: ".7em" };
    const placementPercentLabelPos = {x: col2, y: 85, size: ".7em" };

    
    const div = d3.select(id);

    // The selection rectangle what moves around when the current week changes
    let cursor;
    let cursorVisible = false;
    let selectedRect;
    
    // Include this, and add a dimension and group
    // Later call these on a click to filter: 
    //    _chart.filter(filter);
    //    _chart.redrawGroup();
    const _chart = dc.baseMixin({});
    // This only filters. It doesn't display a group metric, and it does not respond
    // to changes in the group metric based on other filters.

    // Also - make sure to return _chart; at the end of the function, or chaining won't work! 

    const svg = div.append("svg")
        .attr("width", 300)
        .attr("height", (height * 5) + 50);
    
    svg.append("text")
        .attr("x", 55)
        .attr("y", 28)
        .text("Solos")
        .attr("font-size", "1.9em")
        .attr("fill", "black"); 

    svg.append("text")
        .attr("x", duoX + 45)
        .attr("y", 28)
        .text("Duos")
        .attr("font-size", "1.9em")
        .attr("fill", "black");

    const top = 40;
    let count = 0;      
    weeks.forEach(function(week) {

        let weekSelection = {};

        const x = week.type === "Solo" ? soloX : duoX;
        const y = Math.round((count-1)/2) * height + top;

        const yellowGreen = "#9ACD32"
        const red = "lightgrey";
        //const grey = '#B3B3B3';
        const grey = '#606060';

        //let color = (week.type === "Duo") ? yellowGreen : red;
        let color = (week.type === "Duo") ? "lightblue" : "lightblue";
        if (!week.done)
            color = grey;

        const rect = svg.append("rect")
            .attr("data", week.num)
            .attr("x", x)
            .attr("y", y)
            .attr("width", width)
            .attr("height", height - 10)
            .attr("fill", color)
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("rx", cornerRadius)
            .attr("ry", cornerRadius)
            
            .on('mouseover', function (d) {
                const num = d3.select(this).attr("data");

                // The are mousing over the selected item - don't shrink the border
                if ("Week " + num === filters.week)
                    return;

                // Don't do anything for weeks that aren't done     
                if (!weeks.filter(x => x.num == num)[0].done)
                    return;    
                
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", strokeWidthThin)
            })
            .on('mouseout', function (d) {
                let dom = d3.select(this);
                if ("Week " + dom.attr("data") != filters.week)
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0); 
            })
            .on('click', function (d) {
                clickRect(d3.select(this));
            });
        weekSelection.rect = rect;  
        
        stars.push(makeStar(svg, x, y, week.num));

        const label = svg.append("text")
            .attr("x", x + bigLabel.x)
            .attr("y", y + bigLabel.y)
            .text("Week " + (count + 1))
            .attr("font-size", bigLabel.size)
            .attr("fill", "black")    
            .attr("pointer-events", "none");
        weekSelection.label = label;

        weekSelection.placeLabel = makeLabel(svg, x, y, placeLabelPos);
        weekSelection.moneyLabel = makeLabel(svg, x, y, moneyLabelPos);
        weekSelection.winsLabel = makeLabel(svg, x, y, winsLabelPos);

        weekSelection.pointsLabel = makeLabel(svg, x, y, pointsLabelPos);
        weekSelection.elimsLabel = makeLabel(svg, x, y, elimsLabelPos);
        weekSelection.elimPercentLabel = makeLabel(svg, x, y, elimPercentLabelPos);

        weekSelection.placementLabel = makeLabel(svg, x, y, placementLabelPos);
        weekSelection.placementPercentLabel = makeLabel(svg, x, y, placementPercentLabelPos);
        

        weekSelections.push(weekSelection);

        count++;    
    });

    // Make this after the region circles so that always appears "on top"
    cursor = svg.append("rect")
        .attr("x", 0)
        .attr("y", 0)
        .attr("width", width)
        .attr("height", height - 10)
        .attr("fill", "none")
        .attr("stroke", "black")
        .attr("stroke-width", 0)
        .attr("pointer-events", "none")
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius);
    
    function moveCursor(hideIt) {
        if (hideIt) {
            cursorVisible = false;
            cursor
                .transition()
                .duration(100)
                .attr("stroke-width", strokeWidthThick + 2)
                .transition()
                .duration(300)
                .attr("stroke-width", 0);
            return;    
        }
        
        // Bet there is a better way to do this...
        const x = selectedRect._groups[0][0].x.baseVal.value
        const y = selectedRect._groups[0][0].y.baseVal.value

        if (!cursorVisible) {
            cursorVisible = true;
            cursor
                .attr("x", x)
                .attr("y", y); 
            cursor
                .transition()
                .duration(100)
                .attr("stroke-width", strokeWidthThick);
        } else {
            cursor
                .transition()
                .ease(d3.easeBack)
                .duration(350)
                .attr("x", x)
                .attr("y", y) 

            cursorVisible = true;     
        }
    } 


    function makeLabel(svg, x, y, labelPos) {
        return svg.append("text")
            .attr("x", x + labelPos.x)
            .attr("y", y + labelPos.y)
            .style("font-family", "Helvetica, Arial, sans-serif")
            .attr("font-size", labelPos.size)
            .attr("fill", "black")    
            .attr("pointer-events", "none")
            .attr("fill-opacity", "0.0");
    }

    function makeStar(svg, x, y, week) {

        const g = 
            svg.append("g")
               .style("fill-opacity", 0)
               .attr("pointer-events", "none");

        // Solos       
        if (week % 2 == 1) {
            g.append("circle")
                .attr("data", week)
                .attr("cx", 28)
                .attr("cy", 22)
                .attr("r", 10)
                .attr("fill", "gold")
                .attr("transform", "translate(" + (x-13) + "," + (y-7) + ")")
        // Duos
        } else {
           g.append("circle")
                .attr("data", week)
                .attr("cx", 26)
                .attr("cy", 20)
                .attr("r", 7)
                .attr("fill", "gold")
                .attr("transform", "translate(" + (x-13) + "," + (y-7) + ")")
            
            g.append("circle")
                .attr("data", week)
                .attr("cx", 36)
                .attr("cy", 30)
                .attr("r", 7)
                .attr("fill", "gold")
                .attr("transform", "translate(" + (x-13) + "," + (y-9) + ")")
        }
        return g;
        
        // Star (no used)
        /* return svg.append("polygon")
            .attr("data", week)
            .attr("points", "250,75 323,301 131,161 369,161 177,301")
            .style("fill", "gold")
            //.style("opacity", 0)
            .attr("transform", "translate(" + (x-13) + "," + (y-7) + ") scale(.12)")
            .attr("pointer-events", "none"); */
    }

    const clickRect = function(d3Rect) {
        const num = d3Rect.attr("data");

        // Don't do anything for weeks that aren't done     
        if (!weeks.filter(x => x.num == num)[0].done)
            return;   

        const newFilter = "Week " + num;
        
        // 5 things need to happen:

        // 1) Update filters.region
        // 2) Set/unset crossfilter filter
        // 3) Draw correct outlines
        // 4) DC Redraw
        // 5) Update counts

        // Regardless of what happens below, selected player needs to be cleared 
        clearPlayer(null);

        // 1 None were selected, this is the first selection
        if (filters.week === "") {
            filters.week = newFilter;

            _chart.filter(filters.week);
            d3Rect
                .transition()
                .duration(100)
                .attr("stroke-width", strokeWidthThick);

            _chart.redrawGroup();   
            updateCounts();

            selectedRect = d3Rect;
            moveCursor(false);
            return;
        }

        // 2 One is selected, so unselect it and select this
        if (filters.week != newFilter) {
            const oldFilter = filters.week;

            // Un-border old one
            weekSelections.forEach(function(week) {
                let dom = d3.select(week.rect._groups[0][0]);
                if ("Week " + dom.attr("data") == oldFilter) {
                    // This will toggle it off
                    _chart.filter(oldFilter);
                    dom
                        .transition()
                        .duration(100)
                        .attr("stroke-width", 0)
                }
            });

            filters.week = newFilter;
            _chart.filter(filters.week);
            d3Rect
                .transition()
                .duration(100)
                .attr("stroke-width", 0);

            _chart.redrawGroup();   
            updateCounts();

            selectedRect = d3Rect;
            moveCursor(false);
            return;
        }   

        // 3 This was selected, so unselect it - all will be selected
        filters.week = "";
        _chart.filter(null);
        d3Rect
            .transition()
            .duration(100)
            .attr("stroke-width", 0);
        
        _chart.redrawGroup();  

        selectedRect = d3Rect;
        moveCursor(true); 
        updateCounts();
    }

    const showSinglePlayer = function(player) {
        const neverShowPlace = player === "";
        const recs = facts.all().filter(x => x.player === player);

        const top = 40;
        let count = 0;      
        weeks.forEach(function(week) {
            // Add commas to number
            const num = d3.format(",d");	
            
            const matches = recs.filter(x => week.name === x.week);
            const showPlace = (matches.length != 0) && (!neverShowPlace);
            const labelSize = showPlace ? smallLabel : bigLabel;
            const opacity = showPlace ? "1.0" : "0.0";  

            // Show the star if they qualified, otherwise hide
            const qualified = ((matches.length != 0) &&(matches[0].soloQual + matches[0].duoQual) > 0); 
            stars[count]
                .transition()
                .style("fill-opacity", qualified ? 1 : 0);

            const pctFormat = d3.format(",.1%")
            let place = "";
            let money = "";
            let wins = "";
            let points = "";
            let elims = "";
            let elimPercent = "";
            let placement = "";
            let placementPercent = "";
            if (showPlace) {
                place = "# " + matches[0].rank;
                money = "$" + num(matches[0].payout);
                wins = matches[0].wins.toString() + (wins === 1 ? " win" : " wins")
                points = matches[0].points + " points";
                elims = matches[0].elims.toString() + (elims === 1 ? " elim" : " elims")
                elimPercent = pctFormat(matches[0].elims / matches[0].points) + " elim";   
                placement = matches[0].placementPoints.toString() + " place";
                placementPercent = pctFormat(matches[0].placementPoints / matches[0].points) + " place";    
            }
                
            // Copied from above!!
            const x = week.type === "Solo" ? soloX : duoX;
            const y = Math.round((count-1)/2) * height + top;

            weekSelections[count].label
                .transition()
                .attr("x", x + labelSize.x)
                .attr("y", y + labelSize.y)
                .attr("font-size", labelSize.size);

            weekSelections[count].placeLabel
                .text(place)
                .transition()
                .attr("fill-opacity", opacity);

            weekSelections[count].moneyLabel
                .text(money)
                .transition()
                .attr("fill-opacity", opacity);

            weekSelections[count].winsLabel
                .text(wins) 
                .transition()
                .attr("fill-opacity", opacity);
                
            weekSelections[count].pointsLabel
                .text(points) 
                .transition()
                .attr("fill-opacity", opacity);
            
            weekSelections[count].elimsLabel
                .text(elims) 
                .transition()
                .attr("fill-opacity", opacity);

            weekSelections[count].elimPercentLabel
                .text(elimPercent) 
                .transition()
                .attr("fill-opacity", opacity);
                
             weekSelections[count].placementLabel
                .text(placement) 
                .transition()
                .attr("fill-opacity", opacity);

             weekSelections[count].placementPercentLabel
                .text(placementPercent) 
                .transition()
                .attr("fill-opacity", opacity);
            
            count++;
        });

        updateCounts();
    };

    // Assign this function to global variable so the player can call it when a plyer is clicked!! 
    showPlayerOnWeekChart = showSinglePlayer; 


    return _chart;
}