import { colors } from "./shared.js";


d3.json('fwc/data/games.json').then(function (players) {
    let playerInfos = [];
    players.forEach(function (d) {
        let rec = {};
        rec.name = d[0];
        rec.nationality = d[1];
        rec.team = d[2];
        rec.age = d[3];
        playerInfos.push(rec);
    });
    console.log("Players");    
}); 