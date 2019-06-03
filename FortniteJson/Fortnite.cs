﻿using System.Collections.Generic;
using System.IO;

using Newtonsoft.Json;


namespace FortniteJson {

    public class Place {
        public string week;
        public int soloQual;
        public int duoQual;
        public string soloOrDuo;
        public string player;
        public string region;
        public int rank;
        public int payout;
        public int points;
        public int wins;
        public int elims;
    }

    public class Fortnite {

        public static void MakeJson() {

            var places = new List<Place>();
            var reader = SqlUtil.Query("SELECT * FROM StatView");
            while (reader.Read()) {
                var place = new Place();
                place.week = reader["week"].ToString();
                place.soloQual = (System.Int32)reader["soloWeek"];
                place.duoQual = (System.Int32)reader["duoWeek"];
                place.soloOrDuo = reader["soloOrDuo"].ToString();
                place.player = reader["player"].ToString();
                place.region = reader["region"].ToString();
                place.rank = (System.Int32)reader["rank"];
                place.payout = (System.Int32)reader["payout"];
                place.points = (System.Int32)reader["points"];
                place.wins = (System.Int32)reader["wins"];
                place.elims = (System.Int32)reader["elims"];
                places.Add(place);
            }
            reader.Close();

            string fileName = @"c:\fortnite\FortniteWorldCup\data\data.json";

            string json = JsonConvert.SerializeObject(places);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            File.WriteAllText(fileName, niceJson);
        }
    }
}
