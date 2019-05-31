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
  

console.log ("WWKS!!!");

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
            .attr("y", y)
            .attr("width", width)
            .attr("height", height - 10)
            .attr("fill", "black")
            .classed("week-chart", true);

        svg.append("text")
            .attr("x", x + 6)
            .attr("y", y + 20)
            .text("Week " + (count + 1))
            .attr("font-size", "1.2em")
            .attr("fill", "black");
        
        count++;    
    });
}