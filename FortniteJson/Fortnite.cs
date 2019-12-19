﻿using System.Collections.Generic;
using System.IO;

using Newtonsoft.Json;
using Microsoft.VisualBasic.FileIO;


namespace FortniteJson {


    public class Event {
        public int id;
        public string name;
        public int weekId;
        // Format, Date, Match

        public Event(int id, string name, int weekId) {
            this.id = id;
            this.name = name;
            this.weekId = weekId;
        }

        public static List<Event> GetEvents() {
            var events = new List<Event>();
            var reader = Db.Query("SELECT ID, Name, WeekId FROM Event ORDER BY ID");
            while (reader.Read()) {
                events.Add(new Event(
                    (int)reader["ID"],
                    (string)reader["Name"],
                    (int)reader["WeekID"])
                );            }
            return events;
        }
    }

    public class Dimensions {

        public List<List<string>> players;
        public List<Event> events;
        public List<WeekWeight> weekWeights;

        public Dimensions() {
            players = new List<List<string>>();
            var reader = Db.Query("SELECT * FROM PlayerFrontEndChampionSeriesView");
            while (reader.Read()) {
                var record = new List<string>();
                record.Add(reader["id"].ToString());
                record.Add(reader["name"].ToString());
                record.Add(reader["nationality"].ToString());
                record.Add(reader["team"].ToString());
                record.Add(reader["age"].ToString());
                record.Add(reader["CsAverage"].ToString());
                record.Add(reader["RegionID"].ToString());
                players.Add(record);
            }

            events = Event.GetEvents();
            weekWeights = WeekWeight.GetWeekWeights("100");
        }
    }

    
    public class Game {
        public List<string> fields;
        public List<string> players;

        public Game() {
            fields = new List<string>();
            players = new List<string>();
        } 
    }

    public class EventPayout {
        public string region;
        public int rank;
        public int payout;
    }


    // Used in GetPlacementPoints() below
    public struct Tier {
        public int place, points;

        public Tier(int p1, int p2) {
            place = p1;
            points = p2;
        }
    }

    // Not actually used anymore - send an array instead 
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
        public double powerPoints;
        public string eventPlayerName;
    }


    public class Fortnite {

        public static void MakeDimensions() {
            var dimensions = new Dimensions();

            string fileName = @"c:\project\fortnite\ping\data\dimensions.json";

            string json = JsonConvert.SerializeObject(dimensions);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            File.WriteAllText(fileName, niceJson);
        }


        public static void MakeJsonArray() {

            var array = GetArray();

            string fileName = @"c:\project\fortnite\ping\data\data.json";

            string json = JsonConvert.SerializeObject(array);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            File.WriteAllText(fileName, niceJson);

            MakePlayerArray();
        }

        public static void MakePlayerArray() {
            var list = new List<List<string>>();
            //var reader = SqlUtil.Query("SELECT * FROM PlayerFrontEndView");
            var reader = Db.Query("SELECT * FROM PlayerFrontEndChampionSeriesView");
            while (reader.Read()) {
                var record = new List<string>();
                record.Add(reader["id"].ToString());
                record.Add(reader["name"].ToString());
                record.Add(reader["nationality"].ToString());
                record.Add(reader["team"].ToString());
                record.Add(reader["age"].ToString());
                record.Add(reader["CsAverage"].ToString());
                list.Add(record);
            }

            string fileName = @"c:\project\fortnite\ping\data\players.json";

            string json = JsonConvert.SerializeObject(list);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            File.WriteAllText(fileName, niceJson);
        }

        //public static void MakeJson() {

        //    var places = GetPlaces();

        //    string fileName = @"c:\fortnite\fwc\data\data.json";

        //    string json = JsonConvert.SerializeObject(places);
        //    var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
        //    File.WriteAllText(fileName, niceJson);
        //}

        private static List<List<string>> GetArray() {
            var list = new List<List<string>>();
            var reader = Db.Query("SELECT * FROM StatsView");
            while (reader.Read()) {
                var record = new List<string>();
                record.Add(reader["soloWeek"].ToString());
                record.Add(reader["duoWeek"].ToString());
                record.Add(reader["soloOrDuo"].ToString());
                record.Add(reader["player"].ToString());
                record.Add(reader["regionId"].ToString());
                record.Add(reader["nationality"].ToString());
                record.Add(reader["team"].ToString());
                record.Add(reader["rank"].ToString());
                record.Add(reader["payout"].ToString());
                record.Add(reader["points"].ToString());
                record.Add(reader["wins"].ToString());
                record.Add(reader["elims"].ToString());
                record.Add(reader["PlacementPoints"].ToString());
                record.Add(reader["EarnedQualification"].ToString());

                record.Add(reader["RawPowerPoints"].ToString());
                record.Add(reader["EventPlayerName"].ToString());
                record.Add(reader["PlayerID"].ToString());
                record.Add(reader["EventID"].ToString());

                //if (reader["week"].ToString() == "Solo Final")
                //    record[0] = record[0];

                list.Add(record);
            }
            reader.Close();

            return list;
        }

        //private static List<Place> GetPlaces() {
        //    var places = new List<Place>();
        //    var reader = Db.Query("SELECT * FROM StatsView");
        //    while (reader.Read()) {
        //        var place = new Place();
        //        place.week = reader["event"].ToString();
        //        place.soloQual = (System.Int32)reader["soloWeek"];
        //        place.duoQual = (System.Int32)reader["duoWeek"];
        //        place.soloOrDuo = reader["soloOrDuo"].ToString();
        //        place.player = reader["player"].ToString();
        //        place.region = reader["region"].ToString();
        //        place.nationality = reader["nationality"].ToString();
        //        place.team = reader["team"].ToString();
        //        place.rank = (System.Int32)reader["rank"];
        //        place.payout = (System.Int32)reader["payout"];
        //        place.points = (System.Int32)reader["points"];
        //        place.wins = (System.Int32)reader["wins"];
        //        place.elims = (System.Int32)reader["elims"];
        //        place.placementPoints = (System.Int32)reader["PlacementPoints"];
        //        place.earnedQualifications = (System.Int32)reader["EarnedQualification"];

        //        places.Add(place);
        //    }
        //    reader.Close();

        //    return places;
        //}

        // Out of date & not used (browser makes csv)
        public static void MakeCsv() {

            var lines = new List<string>();
            var header = "\"week\",\"soloWeek\",\"duoWeek\",\"soloOrDuo\",\"player\",\"region\",\"rank\",\"payout\",\"points\",\"wins\",\"elims\",\"placementPoints\",\"earnedQualification\"";
            //var header = "\042week\042,\042soloWeek\042,\042duoWeek\042,\042soloOrDuo\042,\042player\042,\042region\042,\042rank\042,\042payout\042,\042points\042,\042wins\042,\042elims\042,\042placementPoints\042,\042earnedQualification\042";

            lines.Add(header);

            var reader = Db.Query("SELECT * FROM StatsView");

            while (reader.Read()) {
                var fields = new List<string>();

                fields.Add(reader["event"].ToString());
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

                lines.Add("\"" + string.Join("\",\"", fields) + "\"");
            }
            string fileName = @"c:\fortnite\fwc\data\data.csv";

            File.WriteAllText(fileName, string.Join("\n", lines));
        }

        private static int GetPlacementPoints(int rank, string week) {

            // Super inefficient...
            var tiers = new List<Tier>();

            if (week == "11") {
                //var tierReader = SqlUtil.Query("SELECT Rank, Points FROM RankPointTier WHERE RegionID = (SELECT ID FROM Region WHERE Name = 'NA East') AND WeekID = 10 ORDER BY Rank");
                //while (tierReader.Read())
                //    tiers.Add(new Tier((int)tierReader["Rank"], (int)tierReader["Points"]));
                //tierReader.Close();

                tiers.Add(new Tier(1, 3));
                tiers.Add(new Tier(5, 2));
                tiers.Add(new Tier(10, 2));
                tiers.Add(new Tier(15, 3));
            } else {
                // SOLOS aren't in DB!!!
                tiers.Add(new Tier(1, 3));
                tiers.Add(new Tier(5, 2));
                tiers.Add(new Tier(15, 2));
                tiers.Add(new Tier(25, 3));
            }

            int points = 0;
            foreach (Tier tier in tiers)
                if (tier.place >= rank)
                    points += tier.points;

            return points;
        }


        public static void MakeGames() {

            var games = MakeWorldCupGamesGames();

            string fileName = @"c:\project\fortnite\fwc\data\finals.json";

            string json = JsonConvert.SerializeObject(games);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            File.WriteAllText(fileName, niceJson);
        }

        public static void MakeSquadGames() {

            var games = MakeSquadGameList();

            string fileName = @"c:\project\fortnite\ping\data\squad_finals.json";

            string json = JsonConvert.SerializeObject(games);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            File.WriteAllText(fileName, niceJson);
        }

        public static void MakeSquadPayouts() {

            var payouts = MakeSquadPayoutList();

            string fileName = @"c:\project\fortnite\ping\data\squad_finals_payout.json";

            string json = JsonConvert.SerializeObject(payouts);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            File.WriteAllText(fileName, niceJson);
        }


        public static List<Game> MakeWorldCupGamesGames() {

            var list = new List<Game>();

            // ORDERING is important!!
            string query = "SELECT PlacementID, Player, SecondsAlive, EndTime, GameRank, Elims , EndSeconds, PlacementRank, WeekID FROM WorldCupFinalView ORDER BY WeekID, PlacementID, EndTime";
            var reader = Db.Query(query);

            Game game = null;
            string placementId = "";
            int endSeconds = 0;
            while (reader.Read()) {

                if ((game == null) || (placementId != reader["PlacementID"].ToString()) || endSeconds != (int)reader["EndSeconds"]) {
                    game = new Game();
                    game.players.Add(reader["Player"].ToString());

                    game.fields.Add(reader["SecondsAlive"].ToString());
                    game.fields.Add(reader["EndTime"].ToString());
                    game.fields.Add(reader["GameRank"].ToString());
                    game.fields.Add(reader["Elims"].ToString());
                    game.fields.Add(reader["EndSeconds"].ToString());
                    game.fields.Add(
                        GetPlacementPoints((int)reader["GameRank"], reader["WeekID"].ToString()).ToString());
                    game.fields.Add(reader["PlacementId"].ToString());
                    game.fields.Add(reader["PlacementRank"].ToString());
                    game.fields.Add(reader["EventID"].ToString());

                    placementId = reader["PlacementID"].ToString();
                    endSeconds = (int)reader["EndSeconds"];

                    list.Add(game);
                } else {
                    game.players.Add(reader["Player"].ToString());
                }
            }

            return list;

            string fileName = @"c:\fortnite\fwc\data\duo_games.json";

            string json = JsonConvert.SerializeObject(list);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            File.WriteAllText(fileName, niceJson);

        }


        public static List<Game> MakeSquadGameList() {

            var list = new List<Game>();

            // ORDERING is important!!
            //string query = "SELECT PlacementID, Player, SecondsAlive, EndTime, GameRank, Elims , EndSeconds, PlacementRank, WeekID FROM WorldCupFinalView ORDER BY WeekID, PlacementID, EndTime";
            string query = "SELECT PlacementID, Player, SecondsAlive, EndTime, GameRank, Elims , EndSeconds, PlacementRank, Region FROM SquadFinalView ORDER BY Region, PlacementID, EndTime";
            var reader = Db.Query(query);

            Game game = null;
            string placementId = "";
            int endSeconds = 0;
            while (reader.Read()) {

                if ((game == null) || (placementId != reader["PlacementID"].ToString()) || endSeconds != (int)reader["EndSeconds"]) {
                    game = new Game();
                    game.players.Add(reader["Player"].ToString());

                    game.fields.Add(reader["SecondsAlive"].ToString());
                    game.fields.Add(reader["EndTime"].ToString());
                    game.fields.Add(reader["GameRank"].ToString());
                    game.fields.Add(reader["Elims"].ToString());
                    game.fields.Add(reader["EndSeconds"].ToString());
                    game.fields.Add(GetSquadPlacementPoints((int)reader["GameRank"]).ToString());
                    game.fields.Add(reader["PlacementId"].ToString());
                    game.fields.Add(reader["PlacementRank"].ToString());
                    game.fields.Add(reader["Region"].ToString());

                    placementId = reader["PlacementID"].ToString(); // ?
                    endSeconds = (int)reader["EndSeconds"];  // ?
                    list.Add(game);
                } else {
                    game.players.Add(reader["Player"].ToString());
                }
            }

            return list;
        }

        public static List<EventPayout> MakeSquadPayoutList() {
            
            var payouts = new List<EventPayout>();

            string query =
                "SELECT r.Name, p.Rank, p.Payout FROM Placement p " +
                "JOIN Region r on r.ID = p.RegionId " +
                "WHERE p.EventID = 2039 ORDER BY r.Name, p.Rank";

            var reader = Db.Query(query);
            while (reader.Read()) {
                var pay = new EventPayout();
                pay.region = reader["Name"].ToString();
                pay.rank = (int)reader["rank"];
                pay.payout = (int)reader["payout"];
                payouts.Add(pay);
            }

            return payouts;
        }


        private static int GetSquadPlacementPoints(int rank) {

            var tiers = new List<Tier>();
            tiers.Add(new Tier(1, 3));
            tiers.Add(new Tier(2, 3));
            tiers.Add(new Tier(3, 3));
            tiers.Add(new Tier(6, 3));
            tiers.Add(new Tier(8, 3));

            int points = 0;
            foreach (Tier tier in tiers)
                if (tier.place >= rank)
                    points += tier.points;

            return points;
        }
    }
}
