import {cornerRadius} from "./main.js";


export function playerProfile() {
    
    const width = 320; // Fits smallest iphone 
    
    const weekHeight = 94;

    let name;


    const div = d3.select(".gradient")
        .append("div")
        .classed("player-profile-div", true)
        .style("display", "none");
		//.attr('top', "10px")
		//.attr('right', "10px")
		//.attr('width', "500px")
        //.attr('left', "10px")
        
    const svg = div.append("svg")
        .attr("width", 320)
        .attr("height", (weekHeight * 5) + 120);

     const rect = svg.append("rect")
        .attr("x", 3)
        .attr("y", 3)
        .attr("width", 320 - 6)
        .attr("height", (weekHeight * 5) + 120 - 6)
        .attr("fill", "none")
        .attr("stroke", "black")
        .attr("stroke-width", 5)
        .attr("pointer-events", "none")
        .attr("rx", cornerRadius)
        .attr("ry", cornerRadius)
        .classed("player-profile-rect", true); 
    
    name = svg.append("text")
        .attr("x", 14)
        .attr("y", 40)
        .text("Tfue")
        .attr("font-size", "2.2em")
        .attr("fill", "black")
        .attr("pointer-events", "none");
       

    closeButton();

    function clickX() {
        div.style("display", "none");
    }    

    function closeButton() {
        svg.append("circle")
            .attr("cx", width - 27)
            .attr("cy", 27)
            .attr("r", 16)
            .attr("fill", "lightblue")
            .attr("stroke", "black")
            .attr("stroke-width", 0)
            .on('mouseover', function (d) {
                d3.select(this)
                    .transition()
                    .duration(50)
                    .attr("stroke-width", 4)
            })
            .on('mouseout', function (d) {
                d3.select(this)
                    .transition()
                    .duration(50)
                    .attr("stroke-width", 0); 
            })
            .on('click',clickX);
        
        svg.append("text")
            .attr("x", width - 34)
            .attr("y", 34)
            .text("x")
            .attr("font-size", "1.8em")
            .attr("fill", "black")
            .attr("pointer-events", "none"); 
        }

    let drawPlayer = function(player) {
        div.style("display", "block");
        name.text(player);
    }

    return drawPlayer;
}
