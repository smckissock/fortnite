// @language_out ecmascript5



export function setupStats(data) {

    const regionStats = d3.nest()
        .key(d => d.region)
        .key(d => d.player)
        .rollup(function (values) {
            return {
                soloElims: d3.sum(values, d => (d.soloOrDuo === "Solo") ? d.elims : 0),
                duoElims: d3.sum(values, d => (d.soloOrDuo === "Duo") ? d.elims : 0),

                soloPayout: d3.sum(values, d => (d.soloOrDuo === "Solo") ? d.payout : 0),
                duoPayout: d3.sum(values, d => (d.soloOrDuo === "Duo") ? d.payout : 0),

                soloWins: d3.sum(values, d => (d.soloOrDuo === "Solo") ? d.wins : 0),
                duoWins: d3.sum(values, d => (d.soloOrDuo === "Duo") ? d.wins : 0),

                soloPoints: d3.sum(values, d => (d.soloOrDuo === "Solo") ? d.points : 0),
                duoPoints: d3.sum(values, d => (d.soloOrDuo === "Duo") ? d.points : 0)
            };
        })
        .entries(data);

    function statsForPlayer(region, player) {
        const regionPlayers = regionStats.filter(d => d.key === region)[0].values;
        const stats = regionPlayers.filter(d => d.key === player)[0].value;

        stats.soloElimsRank = 1;
        stats.duoElimsRank = 1;
        stats.totalElimsRank = 1;

        stats.soloPayoutRank = 1;
        stats.duoPayoutRank = 1;
        stats.totalPayoutRank = 1;

        stats.soloWinsRank = 1;
        stats.duoWinsRank = 1;
        stats.totalWinsRank = 1;

        stats.soloPointsRank = 1;
        stats.duoPointsRank = 1;
        stats.totalPointsRank = 1;

        function increment(player, other, field) {
            // Solo or Duo 
            if (field.includes("duo") || (field.includes("solo"))) {
                if (player[field] < other[field]) 
                    player[field + "Rank"]++;
                return;
            }

            // Totals handled differently
            const stat = field.replace("total", "");
            const totalOther = other["duo" + stat] + other["solo" + stat];
            const totalPlayer = player["duo" + stat] + player["solo" + stat];
            if (totalOther > totalPlayer) {
                player[field + "Rank"]++;
                return;
            }
        }

        regionPlayers.forEach(function (d) {
            increment(stats, d.value, "soloElims");
            increment(stats, d.value, "duoElims");
            increment(stats, d.value, "totalElims");
            increment(stats, d.value, "soloPayout");
            increment(stats, d.value, "duoPayout");
            increment(stats, d.value, "totalPayout");

            increment(stats, d.value, "soloWins");
            increment(stats, d.value, "duoWins");
            increment(stats, d.value, "totalWins");
            increment(stats, d.value, "soloPoints");
            increment(stats, d.value, "duoPoints");
            increment(stats, d.value, "totalPoints");

        })
        return stats;
    }

    return statsForPlayer;
}


export const colors = {
    green: '#66c2a5',
    purple: '#fc8d62',
    blue: '#8da0cb',
    red: '#e78ac3', //#e25856'
    teal: '#a6d854',
    brown: '#ffea3f',
    lime: '#3CFF3E', // not used
    grey: '#B3B3B3', // not used

}

// ['#66c2a5','#fc8d62','#8da0cb','#e78ac3','#a6d854','#ffd92f'] 

// too light
//['#b3e2cd', '#fdcdac', '#cbd5e8', '#f4cae4', '#e6f5c9', '#fff2ae']

