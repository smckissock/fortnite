import { colors } from "./shared.js";

let games;
let teams;


d3.json('fwc/data/games.json').then(function (data) {
    games = [];
    data.forEach(function (d) {
        let rec = {};
        //rec.name = d.fields[0];
        rec.secondsAlive = d.fields[0];
        rec.endTime = d.fields[1];
        rec.rank = d.fields[2];
        rec.elims = d.fields[3];
        rec.endSeconds = d.fields[4];
        rec.placementPoints = d.fields[5];
        rec.placementId = d.fields[6];

        rec.players = [];
        rec.players[0] = d.players[0];
        rec.players[1] = d.players[1];

        games.push(rec);
    });

    teams = d3.nest()
        .key(d => d.placementId)
        .entries(games);

    //console.log("games");

    draw();
});

function draw() {
    //console.log(games);
    console.log(teams);
}