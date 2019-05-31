const soloX = 10;
const duoX = 155; 

const width = 135;
const height = 80;

const weeks = [
    {type:"Solo"},
    {type:"Duo"},
    {type:"Solo"},
    {type:"Duo"},
    {type:"Solo"},
    {type:"Duo"},
    {type:"Solo"},
    {type:"Duo"},
    {type:"Solo"},
    {type:"Duo"},
];
  

function weekChart(id) {

    let div = d3.select(id);

    let svg = div.append("svg")
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
            .on('mousedown', function (d) {
                console.log("DOWN")
                d3.select(this)
                    .transition()
                    .duration(100)
                    .attr("stroke-width", 12)
            })

        svg.append("text")
            .attr("x", x + 10)
            .attr("y", y + 25)
            .text("Week " + (count + 1) + " " + week.type)
            .attr("font-size", "1.1em")
            .attr("fill", "black")
            .attr("pointer-events", "none");
        count++;    
    });
}