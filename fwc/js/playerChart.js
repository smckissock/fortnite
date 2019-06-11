"use strict"


function playerChart(id) {

    const columns = [
        {name: "Player", code: "player", x: 20},
        //{name: "Solo Qual", code: "soloQual"},
        //{name: "Duo Qual", code: "duoQual"},
        {name: "Payout", code: "payout", x: 9},
        {name: "Points", code: "points", x: 13},
        {name: "Wins", code: "wins", x: 17},
        {name: "Elims", code: "elims", x: 15}
    ];

    
    const headerPos = {left: 150, top: 0, height: 50, width: 80, gap: 7};

    const playerColWidth = 200;
    PlayerTableWidth = playerColWidth + (headerPos.width * (columns.length - 1));
    
    const _chart = dc.baseMixin({});

    const top = headerPos.height + 10;
    const rowHeight = 36; 
    const rowCount = 19;

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
    
         svg.selectAll("rect").data(columns).enter().append("rect")
            .attr("x", (d, i) => (i == 0) ? 0 : playerColWidth + headerPos.gap + (headerPos.width * (i - 1)))
            .attr("y", headerPos.top + 4)
            .attr("width", (d, i) => (i == 0) ? playerColWidth : headerPos.width - headerPos.gap - 3) // -3 because right-most was having its right border cup off 
            .attr("height", headerPos.height)
            //.attr("fill", "yellow") 
            .attr("fill", (d, i) => (i == 0) ? "none" : "lightblue")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .on('mouseover', function (d) {
                // The are mousing over the selected item - don't shrink the border
                //if ("Week " + num === filters.week)
                //    return;
                
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 3);
            })
            .on('mouseout', function (d) {
                // The are mousing over the selected item - don't shrink the border
                //if ("Week " + num === filters.week)
                //    return;
                
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 0);
            }); 

        columnHeaderText();
    }

    function columnHeaderText() {
        svg.selectAll("text").data(columns).enter().append("text")
            .attr("x", (d, i) => (i == 0) ? columns[i].x : playerColWidth + headerPos.gap + (headerPos.width * (i - 1)) + columns[i].x    )
            .attr("y", (d, i) => (i == 0) ? 42 : 35)
            .text((d, i) => columns[i].name)
            .attr("font-family", "burbank")
            .attr("font-size", (d, i) => i ===0 ? "1.8em" : "1.3em")
            .attr("fill", "black")    
            .attr("pointer-events", "none");
    }

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
                .attr("fill", player.color) 
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
            console.log("CLEAR PLAYER");
            return;
        }

        // Below are cases where they clicked a player row 
        const clickedNode = d3.select(node);
        const clickedPlayer = playerRows[clickedNode.attr("data")].key;

        // 1) None were clicked
        if (filters.player === "") {
            filters.player = clickedPlayer;

            clickedNode.attr("stroke-width", "8");
            showPlayerOnWeekChart(clickedPlayer);
            selectedRect = clickedNode;
            return;
        }

        // 2 One is selected, so unselect it and select this
        if (filters.player != "") {
            selectedRect.attr("stroke", 0);
            selectedRect = clickedNode;

            filters.player = clickedPlayer;
            clickedNode.attr("stroke-width", "8");
            showPlayerOnWeekChart(clickedPlayer);
            return;
        }

        // 3 This was selected, so unselect it - all will be selected
        clickedNode.attr("stroke-width", "8");
        filters.player = "";
        selectedRect = null;

        showPlayerOnWeekChart(clickedPlayer);
    }

       
    function renderRows (sections) {

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

        const sortColumn = "payout";

        let values = d3.nest()
            .key(function(d) { return d.key; })
            .sortKeys(d3.descending)
            .entries(_chart.dimension().top(Infinity));
            //.slice(_beginSlice, _endSlice));

        let sortedValues = values.sort(function (a, b) {
            return d3.descending(a.values[0].value[sortColumn], b.values[0].value[sortColumn]);
        });

        let toShow = filterPlayersFast(sortedValues, playerDim.top(Infinity));
        filters.playerCount = toShow.length;

        playerRows = [];
        for (let i = 0; i < rowCount; i++) 
            playerRows.push(toShow[i]);
        
        let x = svg.selectAll("text").remove();
        columnHeaderText();

        let rowNum = 0;
        playerRows.forEach(function(row)  {
            const textColor = row.color; 
            svg.selectAll(".row").data(columns).enter().append("text")
                .attr("x", (d, i) => (i == 0) ? 10 : playerColWidth + headerPos.gap + 10 + (headerPos.width * (i - 1)))
                .attr("y", top + (rowNum * rowHeight) + 21)
                .text(function (d, i) {
                    return (i == 0) ? row.key : row.values[0].value[columns[i].code];
                })
                .attr('fill', "black")
                .attr("font-size", "1.3em")
                .attr("pointer-events", "none"); 

            svg.select(".row" + rowNum)
                .attr("fill", row.color);     
                
            rowNum++;    
        });
    }



    //////////////////////////

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