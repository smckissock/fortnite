
// 1st, 2nd, 3rd, etc.  Only works up to 100   
export function placementString(i) {
    var j = i % 10,
        k = i % 100;
    if (j == 1 && k != 11) {
        return i + "st";
    }
    if (j == 2 && k != 12) {
        return i + "nd";
    }
    if (j == 3 && k != 13) {
        return i + "rd";
    }
    return i + "th";
}


export function setupStats(data) {

    const regionStats = d3.nest()
        .key(d => d.region)
        .key(d => d.player)
        .rollup(function (values) {
            return {
                soloElims: d3.sum(values, d => (d.soloOrDuo === "Solo") ? d.elims : 0),
                duoElims: d3.sum(values, d => (d.soloOrDuo === "Duo") ? d.elims : 0),
                trioElims: d3.sum(values, d => (d.soloOrDuo === "Trio") ? d.elims : 0),
                squadElims: d3.sum(values, d => (d.soloOrDuo === "Squad") ? d.elims : 0),

                soloPayout: d3.sum(values, d => (d.soloOrDuo === "Solo") ? d.payout : 0),
                duoPayout: d3.sum(values, d => (d.soloOrDuo === "Duo") ? d.payout : 0),
                trioPayout: d3.sum(values, d => (d.soloOrDuo === "Trio") ? d.payout : 0),
                squadPayout: d3.sum(values, d => (d.soloOrDuo === "Squad") ? d.payout : 0),

                soloWins: d3.sum(values, d => (d.soloOrDuo === "Solo") ? d.wins : 0),
                duoWins: d3.sum(values, d => (d.soloOrDuo === "Duo") ? d.wins : 0),
                trioWins: d3.sum(values, d => (d.soloOrDuo === "Trio") ? d.wins : 0),
                squadWins: d3.sum(values, d => (d.soloOrDuo === "Squad") ? d.wins : 0),

                soloPoints: d3.sum(values, d => (d.soloOrDuo === "Solo") ? d.points : 0),
                duoPoints: d3.sum(values, d => (d.soloOrDuo === "Duo") ? d.points : 0),
                trioPoints: d3.sum(values, d => (d.trioOrDuo === "Trio") ? d.points : 0),
                squadPoints: d3.sum(values, d => (d.soloOrDuo === "Squad") ? d.points : 0),
            };
        })
        .entries(data);

    function statsForPlayer(region, player) {
        //const regionPlayers = regionStats.filter(d => true)[0].values;
        const regionPlayers = regionStats.filter(d => d.key === region)[0].values;
        
        const stats = regionPlayers.filter(d => d.key === player)[0].value;

        stats.soloElimsRank = 1;
        stats.duoElimsRank = 1;
        stats.trioElimsRank = 1;
        stats.squadElimRank = 1;
        stats.totalElimsRank = 1;
        
        stats.soloPayoutRank = 1;
        stats.duoPayoutRank = 1;
        stats.trioPayoutRank = 1;
        stats.squadPayoutRank = 1;
        stats.totalPayoutRank = 1;

        stats.soloWinsRank = 1;
        stats.duoWinsRank = 1;
        stats.trioWinsRank = 1;
        stats.squadWinsRank = 1;
        stats.totalWinsRank = 1;

        stats.soloPointsRank = 1;
        stats.duoPointsRank = 1;
        stats.trioPointsRank = 1;
        stats.squadPointsRank = 1;
        stats.totalPointsRank = 1;

        function increment(player, other, field) {
            // Solo or Duo 
            if (field.includes("duo") || field.includes("solo") || field.includes("trio") || field.includes("squad")) {
                if (player[field] < other[field])
                    player[field + "Rank"]++;
                return;
            }

            // Totals handled differently
            const stat = field.replace("total", "");
            const totalOther = other["duo" + stat] + other["solo" + stat] + other["trio" + stat]+ other["squad" + stat];
            const totalPlayer = player["duo" + stat] + player["solo" + stat] + player["trio" + stat] + player["squad" + stat];
            if (totalOther > totalPlayer) {
                player[field + "Rank"]++;
                return;
            }
        }

        regionPlayers.forEach(function (d) {
            increment(stats, d.value, "soloElims");
            increment(stats, d.value, "duoElims");
            increment(stats, d.value, "trioElims");
            increment(stats, d.value, "squadElims");
            increment(stats, d.value, "totalElims");

            increment(stats, d.value, "soloPayout");
            increment(stats, d.value, "duoPayout");
            increment(stats, d.value, "trioPayout");
            increment(stats, d.value, "squadPayout");
            increment(stats, d.value, "totalPayout");

            increment(stats, d.value, "soloWins");
            increment(stats, d.value, "duoWins");
            increment(stats, d.value, "trioWins");
            increment(stats, d.value, "squadWins");
            increment(stats, d.value, "totalWins");

            increment(stats, d.value, "soloPoints");
            increment(stats, d.value, "duoPoints");
            increment(stats, d.value, "trioPoints");
            increment(stats, d.value, "squadPoints");
            increment(stats, d.value, "totalPoints");
        })
        return stats;
    }

    return statsForPlayer;
}


export const colors = {
    green: '#66c2a5',
    orange: '#fc8d62',
    blue: '#8da0cb',
    pink: '#e78ac3', //#e25856'
    teal: '#a6d854', // light Green
    yellow: '#ffea3f',
    lime: '#3CFF3E', // not used
    grey: '#B3B3B3', 
}

// Writes stats to an svg, with a css class and optional id
export function text(text, svg, style, x, y, id = "") {  
    const textElm = 
        svg.append("text")
        .attr("x", x)
        .attr("y", y)
        .attr("pointer-events", "none")
        .text(text)
        .classed(style, true)

    // Give it an id, if provided    
    if (id != "")
        textElm.attr("id", id);    
}

// Writes stats to an svg, but pass in a css class
export function centeredText(text, svg, style, x1, width, y) {
    svg.append("text")
        .attr("x", x1 + (width / 2))
        .attr("y", y)
        .attr("text-anchor", "middle")
        .text(text)
        .classed(style, true);
} 


// Writes stats to an svg, but pass in a css class
export function rightText(text, svg, style, x1, width, y) {
    if (text === "NaN")
        return;

    svg.append("text")
        .attr("x", x1 + width)
        .attr("y", y)
        .attr("text-anchor", "end")
        .text(text)
        .classed(style, true);
} 
