export function playerCirclePackChart(svg, players) {
    let log = console.log;

    let view;
    let label;
    let node;

    const svgWidth = 800;
    const svgHeight = 800; 

    const div = d3.select("#chart-player");
        svg = div.append("svg")
            .attr("width", svgWidth)
            .attr("height", svgHeight)
            .attr("viewBox", `-${svgWidth / 2} -${svgHeight / 2} ${svgWidth} ${svgHeight}`)
            .attr("transform", "translate(0 -1010)")
        
        let rect =  svg.append("rect") 
            .attr("x", -(svgWidth / 2))
            .attr("y", -(svgHeight / 2))
            .attr("width", svgWidth)
            .attr("height", svgHeight)   
            .attr("fill", "red")
            //.attr("transform", `-${svgWidth / 2} -${svgHeight / 2} ${svgWidth} ${svgHeight}`)

    const playerNodes = 
        players.map(d => ({ 
            name: d.key, 
            parent: "root", 
            value: d.values[0].value.payout, 
            color: d.color
            //name: ""
        })); 
    
    // Add a root
    playerNodes.unshift( {key: "root", parent: "", value: 1, name: "root" } );

    
    let stratify = d3
        .stratify()
        .id(function(d) { return d.key; })
        .parentId(function(d) { return d.parent; })

    // Makes a d3.hierarchy    
    let root = stratify(playerNodes.slice(0, 100)); 

    root
        .sum(d => d.value)
        .sort((a, b) => b.value - a.value)

    // Swap    
    draw(root);
    //d3.json("https://raw.githubusercontent.com/d3/d3-hierarchy/v1.1.8/test/data/flare.json").then(function (data) {
    //    draw(data);
    //});
    

    function draw(data) {   

        let color = d3.scaleLinear()
            .domain([0, 5])
            .range(["hsl(152,80%,80%)", "hsl(228,30%,40%)"])
            .interpolate(d3.interpolateHcl)

        // uncomment
        //let x = d3.hierarchy(data)
        //    .sum(d => d.value)
        //    .sort((a, b) => b.value - a.value)

        let pack = data => d3.pack()
            .size([svgWidth, svgHeight])
            .padding(3)(data)  // x or data
           //     (d3.hierarchy(data)
           // .sum(d => d.value)
           // .sort((a, b) => b.value - a.value)) 

        const root = pack(data);
        let focus = root;
  
        node = svg.append("g")
            .selectAll("circle")
            .data(root.descendants().slice(1))
            .enter()
            .append("circle")
                //.attr("fill", d => d.children ? color(d.depth) : "white")
                .attr("fill", d => d.data.color)
                .attr("pointer-events", d => !d.children ? "none" : null)
                .on("mouseover", function() { d3.select(this).attr("stroke", "#000"); })
                .on("mouseout", function() { d3.select(this).attr("stroke", null); })
                .on("click", d => focus !== d && (zoom(d), d3.event.stopPropagation()))
                .each(d => log(d));    
  
        label = svg.append("g")
            .style("font", "10px sans-serif")
            .attr("pointer-events", "none")
            .attr("text-anchor", "middle")
                .selectAll("text")
            .data(root.descendants())
            .enter()
            .append("text")
                .style("fill-opacity", d => d.parent === root ? 1 : 0)
                //.style("display", d => d.parent === root ? "inline" : "none")
                .style("display", "inline")
                .text(d => d.data.name)
                //.each(d => log(d));
                
        zoomTo([root.x, root.y, root.r * 2], label, node);
    }

    function zoomTo(v) {
        const k = svgWidth / v[2];
        view = v;
  
        label.attr("transform", d => `translate(${(d.x - v[0]) * k},${(d.y - v[1]) * k})`);
        node.attr("transform", d => `translate(${(d.x - v[0]) * k},${((d.y - v[1]) * k)})`);
        node.attr("r", d => d.r * k);
    }
  
    function zoom(focus) {
        
        const transition = svg.transition()
            .duration(d3.event.altKey ? 7500 : 750)
            .tween("zoom", () => {
                const i = d3.interpolateZoom(view, [focus.x , focus.y, focus.r * 2]);  
                return t => zoomTo(i(t));
            });
  
        label 
            .filter(function(d) { return d.parent === focus || this.style.display === "inline"; })
            .transition(transition)
                .style("fill-opacity", d => d.parent === focus ? 1 : 0)
                .on("start", function(d) { if (d.parent === focus) this.style.display = "inline"; })
                .on("end", function(d) { if (d.parent !== focus) this.style.display = "none"; });
    }
  
    return svg.node();
}
