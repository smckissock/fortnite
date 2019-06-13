"use strict"


function playerChart(id) {

    const columns = [
        {name: "Player", code: "player", x: 8}, 
        {name: "Rank", code: "rank", x: 16},
        {name: "Payout", code: "payout", x: 9},
        {name: "Points", code: "points", x: 13},
        {name: "Wins", code: "wins", x: 17},
        {name: "Elims", code: "elims", x: 15}
        //{name: "Placement", code: "placementPoints", x: 15}
    ];


    const colors = { 
        green: '#319236',
        purple: '#9D4DBB',
        blue : '#4C51F7',
        red : '#DB4441',
        teal: '#3E93BC',
        lime: '#3CFF3E',
        grey: '#B3B3B3',
        brown: '#8B4513'
    }
    
    const headerPos = {left: 150, top: 0, height: 69, width: 80, gap: 5};

    const playerColWidth = 240;
    PlayerTableWidth = playerColWidth + (headerPos.width * (columns.length - 1));
    
    const _chart = dc.baseMixin({});

    const top = headerPos.height + 14;
    const rowHeight = 34; 
    const rowCount = 20;

    const thinBorder = 3;
    const thickBorder = 7;

    let numOrRankRect;
    let numOrRankText;
    

    let svgWidth = PlayerTableWidth; //640;

    // Ugh - currently selected rect, so it can be unselected easily
    let selectedRect;

    // The data currently displayed, in order 
    let playerRows = [];

    // Important!!
    // baseMixin has mandatory ['dimension', 'group'], but we don't have a group here. 
    _chart._mandatoryAttributes(['dimension']);

    var _section = function () { return ''; }; // all in one section


    const div = d3.select(id);


    let rows = [];
    for(let i = 0; i < rowCount; i++) 
        rows.push({num: i});

    const svg = div.append("svg")
        .attr("width", svgWidth)
        .attr("height", 1000);

    drawHeaders(svg);
    drawRows(svg)
    
    function drawHeaders() {
    
        // Rects for column headers 
        svg.selectAll("rect").data(columns).enter().append("rect")
            .attr("x", (d, i) => (i == 0) ? 0 : playerColWidth + headerPos.gap + (headerPos.width * (i - 1)))
            .attr("y", headerPos.top + 4)
            .attr("width", (d, i) => (i == 0) ? playerColWidth : headerPos.width - headerPos.gap - 3) // -3 because right-most was having its right border cup off 
            .attr("height", headerPos.height)
            .attr("fill", (d, i) => (i == 0) ? "none" : "lightblue")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("data", d => d)
            .on('mouseover', function (d) {
                // The are mousing over the selected item - don't show a thin border, leave it thick
                if (d.code === filters.sort)
                    return;
                
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", thinBorder);
            })
            .on('mouseout', function (d) {
                // The are leaving over the selected item - don't shrink the border
                if (d.code === filters.sort)
                    return;
                
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 0);
            })
            .on('click', function (d) {
                // They clicked on the selected one, so just ignore
                if (d.code === filters.sort)
                    return;

                // Unselect the old one    
                drawColumnBorder(filters.sort, 0);
                
                filters.sort = d.code;                
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", thickBorder);

                if (filters.player != "")
                    clearPlayer(null);
                else {
                    updateCounts();
                    renderRows();
                }
            })
            .each(function (d, i) {
                if (i === 1) {
                    numOrRankRect = d3.select(this);
                }
            });
        
        columnHeaderText();
        drawColumnBorder("payout", thickBorder);
    }

    function columnHeaderText() {
        svg.selectAll("text").data(columns).enter().append("text")
            .attr("x", (d, i) => (i == 0) ? columns[i].x : playerColWidth + headerPos.gap + (headerPos.width * (i - 1)) + columns[i].x)
            .attr("y", (d, i) => (i == 0) ? 58 : 46)
            .text((d, i) => columns[i].name)
            .attr("font-family", "burbank")
            .attr("font-size", (d, i) => i ===0 ? "1.8em" : "1.3em")
            .attr("fill", "black")    
            .attr("pointer-events", "none")
            .each(function (d, i) {
                if (columns[i].name === "Rank") {
                    numOrRankText = d3.select(this);
                }
            });

    if (numOrRankRect)
        numOrRankRect
            .attr("stroke-width", (filters.week && (filters.sort === "rank")) ? thickBorder : 0);   
    }

    // Only works on start up - just selects first, does not unselect others!
    function drawColumnBorder(sort, strokeWidth) {
        if (!sort)
            throw "You must sort by something";
        
            d3.selectAll('svg')
                .selectAll('rect')
                .each(function(d) {
                    if (d) {
                        if (d.code === sort)
                            d3.select(this)
                                .transition()
                                .duration(100)
                                .attr("stroke-width", strokeWidth);
                    }
                });
    }

    // Draw rects for player rows. These stay, but the text on top of them changes whenever the query changes
    function drawRows() {
        const gap = 6;
        rows.forEach(function(row)  {
            const player = row;
            svg.append("rect")
                .attr("data", player.num)
                .attr("x", 0)
                .attr("y", top + (row.num * rowHeight))
                .attr("width", svgWidth)
                .attr("height", rowHeight - gap)
                .attr("fill", "none") 
                .attr("class", "row" + row.num)
                .attr("visible", "hidden")
                .attr("fill", colors[player.color]) 
                .attr("stroke", "black")
                .attr("stroke-width", 0) 
                .on('mouseover', function (d) {
                    const node = d3.select(this);
                    const player = playerRows[node.attr("data")].key;
                    if (filters.player === player)
                        return;

                    node.attr("stroke-width", "4");
                })
                .on('mouseout', function (d) {
                    const node = d3.select(this);
                    const player = playerRows[node.attr("data")].key;

                    // Don't remove filter is this is the selected player
                    if (filters.player === player)
                        return;

                    node.attr("stroke-width", "0");
                })
                .on('click', function (d) {
                    setPlayer(this);
                })

            svg.append("circle")
                .attr("cx", 16)
                .attr("cy", top + (row.num * rowHeight) + 14)
                .attr("r", 10)
                .attr("fill", "gold")
                .attr("fill-opacity", 0.0)
                .classed("s" + row.num, true);
                
            const g = svg.append("g")
               .style("fill-opacity", 0.0)
               .attr("pointer-events", "none")
               .classed("d" + row.num, true);
               
            g.append("circle")
                .attr("cx", 39)
                .attr("cy", top + (row.num * rowHeight) + 11)
                .attr("r", 7)
                .attr("fill", "gold")

            g.append("circle")
                .attr("cx", 50)
                .attr("cy", top + (row.num * rowHeight) + 18)
                .attr("r", 7)
                .attr("fill", "gold")
        });    
    }

    // Either the player node they clicked or null (they set player to null be because they reset the region, week, search or sort ) 
    function setPlayer(node) {
             
        // 0) Clear the filter - called from elsewhere, e.g. a group filter was set
        if (node === null) {
            filters.player = "";
            if (selectedRect != null) {
                selectedRect.attr("stroke", 0);
                selectedRect = null;
            }
            showPlayerOnWeekChart("");
            return;
        }

        // Below are cases where they clicked a player row 
        const clickedNode = d3.select(node);
        const clickedPlayer = playerRows[clickedNode.attr("data")].key;

        // 1) None were clicked
        if (filters.player === "") {
            filters.player = clickedPlayer;

            clickedNode.attr("stroke-width", thickBorder);
            showPlayerOnWeekChart(clickedPlayer);
            selectedRect = clickedNode;
            return;
        }

        // 2 One is selected, so unselect it and select this
        if (filters.player != "") {
            //selectedRect.attr("stroke", 0);
            selectedRect.attr("stroke-width", 0);
            selectedRect = clickedNode;

            filters.player = clickedPlayer;
            clickedNode.attr("stroke-width", thickBorder);
            showPlayerOnWeekChart(clickedPlayer);
            return;
        }

        // 3 This was selected, so unselect it - all will be selected
        clickedNode.attr("stroke-width", thickBorder);
        filters.player = "";
        selectedRect = null;

        showPlayerOnWeekChart(clickedPlayer);
    }

    
    // Draws current players on top of already-existing rectangles
    function renderRows() {

        // https://stackoverflow.com/questions/32376651/javascript-filter-array-by-data-from-another  search for "O(n^2)""
        function filterPlayersFast(data, dimVals) {
            let names = dimVals.map(x => x.player); 
            var index = names.reduce(function(a,b) {a[b] = 1; return a;}, {});
            let filteredData = data.filter(function(item) {
                item.color = playerColors[item.key];
                return index[item.key] === 1;
            });
            return filteredData;
        }

        const sortColumn = filters.sort;
        const sortOrder = (filters.sort !== "rank") ? d3.descending : d3.ascending;

        let values = d3.nest()
            .key(function(d) { return d.key; })
            .sortKeys(sortOrder)
            .entries(_chart.dimension().top(Infinity));
            //.slice(first, last);  !!!

        let sortedValues = values.sort(function (a, b) {
            return sortOrder(a.values[0].value[sortColumn], b.values[0].value[sortColumn]);
        });

        let results = filterPlayersFast(sortedValues, playerDim.top(Infinity));
        filters.playerCount = results.length;

        // Make a list of 20. Zero based page, zero based slices
        const pageSize = 20;
        const first = pageSize * filters.page;
        const last = (pageSize * (filters.page + 1));
        const toShow = results.slice(first, last);

        playerRows = [];
        for (let i = 0; i < rowCount; i++) 
            playerRows.push(toShow[i]);
        
        let x = svg.selectAll("text").remove();
        columnHeaderText();

        let rowNum = 0;
        playerRows.forEach(function(row)  {
            // Only one player, so simulate a click on him
            if (toShow.length === 1 && rowNum == 0) {
                svg.select(".row0") 
                    .each(function(d) {
                        setPlayer(this);
                    });
            }
            
            // If there is no row (filters returned fewer queries than rows) make the row transarent
            if (!row) {
                svg.select(".row" + rowNum)
                    .attr("fill", "none")
                    .attr("stroke-width", 0);

                // Also hide qualification circles from hidden rows     
                svg.select(".s" + rowNum)
                    .style("fill-opacity", 0);
                svg.select(".d" + rowNum)
                    .style("fill-opacity", 0);

                // Don't do anything else for lower rows - just get out     
                rowNum++;
                return; 
            }

            // Draw the text for the row, including the player name
            svg.selectAll(".row").data(columns).enter().append("text")
                .attr("x", (d, i) => (i == 0) ? 68 : playerColWidth + headerPos.gap + 10 + (headerPos.width * (i - 1)))
                .attr("y", top + (rowNum * rowHeight) + 21)
                .text(function (d, i) {
                    //return (i == 0) ? row.key : row.values[0].value[columns[i].code];
                    if (i == 0) 
                        return row.key;

                    if (i != 1) 
                        return row.values[0].value[columns[i].code];
                        
                    return (filters.week === "") ? rowNum + 1 : row.values[0].value[columns[i].code];
                })
                .attr('fill', "black")
                .attr("font-size", "1.3em")
                .attr("pointer-events", "none"); 

            const rowSelection = svg.select(".row" + rowNum);

            // color the row based on region
            rowSelection
                .transition()
                .attr("fill", colors[row.color]);
                
            // Show/hide solo circles    
            svg.select(".s" + rowNum)
                .transition()
                .style("fill-opacity", (soloQualifications.indexOf(row.key) != -1) ? 1 : 0);
            // Show/hide solo circle groups
            svg.select(".d" + rowNum)
                .transition()
                .style("fill-opacity", (duoQualifications.indexOf(row.key) != -1) ? 1 : 0);
                
            rowNum++;    
        });

        setRowRankColumn();
        updateCounts();
    }

    function setRowRankColumn() {
        if (filters.week === "") {
            numOrRankText
                .text("#")
                .attr("x", playerColWidth + headerPos.gap + columns[1].x + 12)
                .attr("y", 59)
                .attr("font-size", "2.6em");
            
            numOrRankRect
                .attr("fill", "none")
                .attr("pointer-events", "none")
                .attr("stroke-width", 0);

            // Need to shift move sord away from rank when it doesn't make any sense.    
        } else {
            numOrRankText.text("Rank");
            numOrRankRect
                .attr("fill", "lightblue")
                .attr("pointer-events", "auto")
                //.attr("stroke-width", thickBorder)
                //.attr("stroke-width", (numOrRankRect && filters.week) ? thickBorder : 0)
                
        }   
    }



    // DC related stuff
    _chart._doRender = function () {
        renderRows();
        return _chart;
    };

    _chart._doRedraw = function () {
        return _chart._doRender();
    };

    clearPlayer = setPlayer; 

    return _chart;
}