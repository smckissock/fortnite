"use strict"


function playerChart(id) {

    const columns = [
        {name: "Player", code: "player"},
        {name: "Solo Qual", code: "soloQual"},
        {name: "Duo Qual", code: "duoQual"},
        {name: "Payout", code: "payout"},
        {name: "Score", code: "score"},
        {name: "Wins", code: "wins"},
        {name: "Elims", code: "elims"}
    ];

    const playerWidth = 150;
    const headerPos = {left: 150, top: 0, height: 60, width: 80, gap: 4};
    
    const _chart = dc.baseMixin({});
    const div = d3.select(id);

    const rowCount = 20;
    

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
            .attr("fill", "none")
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

        svg.selectAll("text").data(columns).enter().append("text")
            .attr("x", (d, i) => (i == 0) ? 0 : playerWidth + headerPos.gap +  + (headerPos.width * (i - 1)))
            .attr("y", headerPos.top + 35)
            .text((d, i) => columns[i].name)
            .attr("font-size", ".8em")
            .attr("fill", "none")    
            .attr("pointer-events", "none");
    }

    function drawRows() {
        const top = headerPos.height + 10;
        const rowHeight = 34; 
        
        rows.forEach(function(row)  {
            svg.selectAll(".row").data(columns).enter().append("rect")
                .attr("x", (d, i) => (i == 0) ? 0 : playerWidth + headerPos.gap + (headerPos.width * (i - 1)))
                .attr("y", top + (row.num * rowHeight))
                .attr("width", (d, i) => (i == 0) ? playerWidth : headerPos.width - headerPos.gap)
                .attr("height", rowHeight - 2)
                .attr("fill", "none")
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
                        .attr("fill", "yellow");
                });  
        });

    }
}