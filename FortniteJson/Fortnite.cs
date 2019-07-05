using System.Collections.Generic;
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
        public string nationality;
        public string team;
        public int rank;
        public int payout;
        public int points;
        public int wins;
        public int elims;
        public int placementPoints;
        public int earnedQualifications;
    }

    public class Fortnite {

        public static void MakeJson() {

            var places = GetPlaces();
            
            string fileName = @"c:\fortnite\fwc\data\data.json";

            string json = JsonConvert.SerializeObject(places);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            File.WriteAllText(fileName, niceJson);
        }

        private static List<Place> GetPlaces() {
            var places = new List<Place>();
            var reader = SqlUtil.Query("SELECT * FROM StatsWithPlayerInfoView");
            while (reader.Read()) {
                var place = new Place();
                place.week = reader["week"].ToString();
                place.soloQual = (System.Int32)reader["soloWeek"];
                place.duoQual = (System.Int32)reader["duoWeek"];
                place.soloOrDuo = reader["soloOrDuo"].ToString();
                place.player = reader["player"].ToString();
                place.region = reader["region"].ToString();
                place.nationality = reader["nationality"].ToString();
                place.team = reader["team"].ToString();
                place.rank = (System.Int32)reader["rank"];
                place.payout = (System.Int32)reader["payout"];
                place.points = (System.Int32)reader["points"];
                place.wins = (System.Int32)reader["wins"];
                place.elims = (System.Int32)reader["elims"];
                place.placementPoints = (System.Int32)reader["PlacementPoints"];
                place.earnedQualifications = (System.Int32)reader["EarnedQualification"];

                places.Add(place);
            }
            reader.Close();

            return places;
        }


        // Out of date & not used (browser makes csv)
        public static void MakeCsv() {

            var lines = new List<string>();
            var header = "week,soloWeek,duoWeek,soloOrDuo,player,region,rank,payout,points,wins,elims,placementPoints,earnedQualification";
            lines.Add(header);
            
            var reader = SqlUtil.Query("SELECT * FROM StatView");
            
            while (reader.Read()) {
                var fields = new List<string>();

                fields.Add(reader["week"].ToString());
                fields.Add(reader["soloWeek"].ToString());
                fields.Add(reader["duoWeek"].ToString());
                fields.Add(reader["soloOrDuo"].ToString());
                fields.Add(reader["player"].ToString());
                fields.Add(reader["region"].ToString());
                fields.Add(reader["rank"].ToString());
                fields.Add(reader["payout"].ToString());
                fields.Add(reader["points"].ToString());
                fields.Add(reader["wins"].ToString());
                fields.Add(reader["elims"].ToString());
                fields.Add(reader["PlacementPoints"].ToString());
                fields.Add(reader["EarnedQualification"].ToString());

                lines.Add(string.Join(",", fields));
            }
            string fileName = @"c:\fortnite\fwc\data\data.csv";

            File.WriteAllText(fileName, string.Join("\n", lines));
        }
    }
}
