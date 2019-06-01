const weeks = [
    {num: 1, type:"Solo"},
    {num: 2, type:"Duo"},
    {num: 3, type:"Solo"},
    {num: 4, type:"Duo"},
    {num: 5, type:"Solo"},
    {num: 6, type:"Duo"},
    {num: 7, type:"Solo"},
    {num: 8, type:"Duo"},
    {num: 9, type:"Solo"},
    {num: 10, type:"Duo"},
];
  

function weekChart(id) {
    const soloX = 10;
    const duoX = 155; 

    const width = 135;
    const height = 80;
    
    const div = d3.select(id);
    
    // Include this, and add a dimension and group
    // Later call these on a click to filter: 
    //    _chart.filter(filter);
    //    _chart.redrawGroup();
    const _chart = dc.baseMixin({});
    // This only filters. It doesn't display a group metric, and it does not respond
    // to changes in the group metric based on other filters.

    // Also - make sure to return _chart; at the end of the function, or chaining won't work! 

    const bigLabel = {x: 25, y: 48, size: "2em" }
    const smallLabel = {x: 40, y: 30, size: "1.2em" }

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

    const top = 30;
    let count = 0;      
    weeks.forEach(function(week) {
        let x = week.type === "Solo" ? soloX : duoX;
        let y = Math.round((count-1)/2) * height + top;

        svg.append("rect")
            .attr("x", x)
            .attr("y", y + 3)
            .attr("width", width)
            .attr("height", height - 10)
            .attr("fill", "black")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .attr("data", week.num)
            .classed("week-chart", true)
            .on('mouseover', function (d) {
                console.log('RECT');
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 7)
            })
            .on('mouseout', function (d) {
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 0)
            })
            .on('mouseup', function (d) {
                console.log("DOWN")
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 12)

                const filter = "Week " + d3.select(this).attr("data");
                filters.week = filter;
                _chart.filter(filter);
                _chart.redrawGroup();    
                updateCounts(); 
            });

        svg.append("text")
            .attr("x", x + bigLabel.x)
            .attr("y", y + bigLabel.y)
            .text("Week " + (count + 1))
            .attr("font-size", bigLabel.size)
            .attr("fill", "black")    
            .attr("pointer-events", "none");

/*             .attr("x", x + 10)
            .attr("y", y + 25)
            //.text("Week " + (count + 1) + " " + week.type)
            .text("Week " + (count + 1))
            .attr("font-size", "1.1em")
            .attr("fill", "black") */
            
        count++;    
    });

    return _chart;
}