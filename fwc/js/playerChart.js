"use strict"


function playerChart(id) {

    const columns = [
        {name: "Player", code: "player"},
        {name: "Solo Qual", code: "soloQual"},
        {name: "Duo Qual", code: "duoQual"},
        {name: "Payout", code: "payout"},
        {name: "Points", code: "points"},
        {name: "Wins", code: "wins"},
        {name: "Elims", code: "elims"}
    ];

    const playerWidth = 150;
    const headerPos = {left: 150, top: 0, height: 60, width: 80, gap: 4};
    
    const _chart = dc.baseMixin({});

    const top = headerPos.height + 10;
    const rowHeight = 25; 
    const rowCount = 27;

    // Important!!
    // baseMixin has mandatory ['dimension', 'group'], but we don't have a group here. 
    _chart._mandatoryAttributes(['dimension']);

    var _section = function () { return ''; }; // all in one section


    const div = d3.select(id);


    let rows = [];
    for(let i = 0; i < rowCount; i++) 
        rows.push({num: i});

    const svg = div.append("svg")
        .attr("width", 700)
        .attr("height", 1000);

    drawHeaders(svg);
    drawRows(svg)
    
    function drawHeaders() {
    
         svg.selectAll("rect").data(columns).enter().append("rect")
            .attr("x", (d, i) => (i == 0) ? 0 : playerWidth + headerPos.gap + (headerPos.width * (i - 1)))
            .attr("y", headerPos.top + 4)
            .attr("width", (d, i) => (i == 0) ? playerWidth : headerPos.width - headerPos.gap)
            .attr("height", headerPos.height)
            .attr("fill", "none") // Yellow
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .on('mouseover', function (d) {
                // The are mousing over the selected item - don't shrink the border
                //if ("Week " + num === filters.week)
                //    return;
                
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 5);
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

        columnHeaders();
    }

    function columnHeaders() {
        svg.selectAll("text").data(columns).enter().append("text")
            .attr("x", (d, i) => (i == 0) ? 0 : playerWidth + headerPos.gap + (headerPos.width * (i - 1)))
            .attr("y", headerPos.top + 35)
            .text((d, i) => columns[i].name)
            .attr("font-size", ".8em")
            .attr("fill", "black")    
            .attr("pointer-events", "none");
    }

    function drawRows() {
        rows.forEach(function(row)  {
            svg.selectAll(".row").data(columns).enter().append("rect")
                .attr("x", (d, i) => (i == 0) ? 0 : playerWidth + headerPos.gap + (headerPos.width * (i - 1)))
                .attr("y", top + (row.num * rowHeight))
                .attr("width", (d, i) => (i == 0) ? playerWidth : headerPos.width - headerPos.gap)
                .attr("height", rowHeight - 2)
                //.attr("fill", "yellow")
                .attr("fill", "none") // Yellow
                .attr("stroke", "black")
                .attr("stroke-width", 0)
                .attr("class", d => "row" + row.num + " " + d.code)
                .on('mouseover', function (d) {
                    d3.select(this)
                        .transition()
                        .duration(100)
                        .attr("fill", "red");
                })
                .on('mouseout', function (d) {
                    d3.select(this)
                        .transition()
                        .duration(100)
                        //.attr("fill", "yellow"); 
                        .attr("fill", "none") // Yellow
                });  
        });

    }
   

    // This should be fast
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


    function renderRows (sections) {
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
        
        let playerRows = [];
        for (let i = 0; i < rowCount; i++) 
            playerRows.push(toShow[i]);
        
        let x = svg.selectAll("text").remove();

        columnHeaders();

        let rowNum = 0;
        playerRows.forEach(function(row)  {
            const textColor = row.color; 
            svg.selectAll(".row").data(columns).enter().append("text")
                .attr("x", (d, i) => (i == 0) ? 0 : playerWidth + headerPos.gap + (headerPos.width * (i - 1)))
                .attr("y", top + (rowNum * rowHeight) + 16)
                .text(function (d, i) {
                    return (i == 0) ? row.key : row.values[0].value[columns[i].code];
                })
                .attr('fill', textColor)
                .attr("font-size", ".8em")
                .attr("pointer-events", "none");
                
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

    return _chart;
}