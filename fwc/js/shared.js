// @language_out ecmascript5



export function setupStats(data) {

    const stats = d3.nest()
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

        const regionPlayers = stats.filter(d => d.key === region)[0].values;
        const playerStats = regionPlayers.filter(d => d.key === player)[0].value;
        //console.log(playerStats);

        return playerStats;
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

