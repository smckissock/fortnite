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
        {num: 9, name: "Week 9", type:"Solo", done: false},
        {num: 10, name: "Week 10", type:"Duo", done: false},
    ];

    let weekSelections = [];

    const soloX = 10;
    const duoX = 155; 

    const width = 135;
    const height = 87;

    const bigLabel = {x: 25, y: 49, size: "2em" };
    const smallLabel = {x: 40, y: 20, size: "1.2em" };

    const placeLabelPos = {x: 6, y: 35, size: ".8em" };
    const moneyLabelPos = {x: 6, y: 51, size: ".8em" };
    const winsLabelPos = {x: 6, y: 67, size: ".8em" };

    
    const div = d3.select(id);
    
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
        .attr("height", (height * 5) + 30);
    
    svg.append("text")
        .attr("x", 60)
        .attr("y", 25)
        .text("Solo")
        .attr("font-size", "1.6em")
        .attr("fill", "black"); 

    svg.append("text")
        .attr("x", duoX + 45)
        .attr("y", 25)
        .text("Duo")
        .attr("font-size", "1.8em")
        .attr("fill", "black");

    const top = 40;
    let count = 0;      
    weeks.forEach(function(week) {

        let weekSelection = {};

        const x = week.type === "Solo" ? soloX : duoX;
        const y = Math.round((count-1)/2) * height + top;

        const yellowGreen = "#9ACD32"
        const red = "Red";
        const grey = '#B3B3B3';

        let color = (week.type === "Duo") ? yellowGreen : red;
        if (!week.done)
            color = grey;

        const rect = svg.append("rect")
            .attr("x", x)
            .attr("y", y)
            .attr("width", width)
            .attr("height", height - 10)
            .attr("fill", color)
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("data", week.num)
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
                    .attr("stroke-width", 5)
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

        const label = svg.append("text")
            .attr("x", x + bigLabel.x)
            .attr("y", y + bigLabel.y)
            .text("Week " + (count + 1))
            .attr("font-size", bigLabel.size)
            .attr("fill", "black")    
            .attr("pointer-events", "none");
        weekSelection.label = label;

        const placeLabel = svg.append("text")
            .attr("x", x + placeLabelPos.x)
            .attr("y", y + placeLabelPos.y)
            .text("Place")
            .attr("font-size", placeLabelPos.size)
            .attr("fill", "black")    
            .attr("pointer-events", "none")
            .attr("fill-opacity", "0.2");
        weekSelection.placeLabel = placeLabel;

        const moneyLabel = svg.append("text")
            .attr("x", x + moneyLabelPos.x)
            .attr("y", y + moneyLabelPos.y)
            .text("Money")
            .attr("font-size", moneyLabelPos.size)
            .attr("fill", "black")    
            .attr("pointer-events", "none")
            .attr("fill-opacity", "0.2");
        weekSelection.moneyLabel = moneyLabel;

        const winsLabel = svg.append("text")
            .attr("x", x + winsLabelPos.x)
            .attr("y", y + winsLabelPos.y)
            .text("Wins")
            .attr("font-size", winsLabelPos.size)
            .attr("fill", "black")    
            .attr("pointer-events", "none")
            .attr("fill-opacity", "0.2");
        weekSelection.winsLabel = winsLabel;

        weekSelections.push(weekSelection);

        count++;    
    });

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

       // 1 None were selected, this is the first selection
       if (filters.week === "") {
            filters.week = newFilter;

            _chart.filter(filters.week);
            d3Rect
                .transition()
                .duration(100)
                .attr("stroke-width", 9);

            _chart.redrawGroup();   
            updateCounts();
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
                .attr("stroke-width", 9);

            _chart.redrawGroup();   
            updateCounts();

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
        updateCounts();
    }

    const showSinglePlayer = function(player) {
        const neverShowPlace = player === "";
        
        //let labelSize = player === "" ? bigLabel : smallLabel;

        const recs = facts.all().filter(x => x.player === player);
        console.log(recs);

        const top = 40;
        let count = 0;      
        weeks.forEach(function(week) {
            
            const matches = recs.filter(x => week.name === x.week);
            console.log(matches);

            const showPlace = (matches.length != 0) && (!neverShowPlace);

            const labelSize = showPlace ? smallLabel : bigLabel;
            const opacity = showPlace ? "1.0" : "0.1";    
                
            // Copied from above!!
            const x = week.type === "Solo" ? soloX : duoX;
            const y = Math.round((count-1)/2) * height + top;

            //weekLabels[count]
            weekSelections[count].label
                .transition()
                .attr("x", x + labelSize.x)
                .attr("y", y + labelSize.y)
                .attr("font-size", labelSize.size);

            weekSelections[count].placeLabel
                .transition()
                .attr("fill-opacity", opacity);

            weekSelections[count].moneyLabel
                .transition()
                .attr("fill-opacity", opacity);

            weekSelections[count].winsLabel
                .transition()
                .attr("fill-opacity", opacity); 

            count++;
        });
    };

    // Assign this function to global variable so the player can call it when a plyer is clicked!! 
    showPlayerOnWeekChart = showSinglePlayer; 


    return _chart;
}