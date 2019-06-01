const soloX = 10;
const duoX = 155; 

const width = 135;
const height = 80;

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
    const div = d3.select(id);
    
    // Include this, and add a dimension and group
    // Later call these on a click to filter: 
    //    _chart.filter(filter);
    //    _chart.redrawGroup();
    const _chart = dc.baseMixin({});
    // This only filters. It doesn't display a group metric, and it does not respond
    // to changes in the group metric based on other filters.


    const svg = div.append("svg")
            .attr("width", 300)
            .attr("height", (height * 5) + 10);

    let count = 0;        
    weeks.forEach(function(week) {
        let x = week.type === "Solo" ? soloX : duoX;
        let y = Math.round((count-1)/2) * height;

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
                _chart.filter(filter);
                _chart.redrawGroup();    
                updateCounts(); 
            });

        svg.append("text")
            .attr("x", x + 10)
            .attr("y", y + 25)
            .text("Week " + (count + 1) + " " + week.type)
            .attr("font-size", "1.1em")
            .attr("fill", "black")
            .attr("pointer-events", "none");
        count++;    
    });

    return _chart;
}