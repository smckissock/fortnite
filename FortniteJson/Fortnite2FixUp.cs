using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using Microsoft.VisualBasic.FileIO;
using System.IO;



namespace FortniteJson {

    public static class Fortnite2FixUp {

        private static string weekId = "17";  // CHANGE THIS

        public static void FixCurrentName() {
            return;

            var reader = Db.Query("SELECT PlayerID, PlayerName, EventID FROM PlayerEvent ORDER BY playerID, EventID");

            int oldPlayerId = 0;
            string oldName = "";
            while (reader.Read()) {
                if (oldPlayerId == 0) {
                    oldPlayerId = (int)reader[0];
                    oldName = (string)reader[1];
                }

                if (oldPlayerId != (int)reader[0]) {
                    Db.Command("UPDATE Player SET CurrentName = N'" + oldName + "' WHERE ID = " + oldPlayerId);
                    oldPlayerId = (int)reader[0];
                    oldName = (string)reader[1];
                }
                oldName = (string)reader[1];
            }
            Db.Command("UPDATE Player SET CurrrentName = '" + oldName + "' WHERE ID = " + oldPlayerId);
        }


        public static void FixPayoutElimsAndWins (ImportInfo info) {
            FixPlacementPayout(info.EventId);
            FixPlacementElims(info.EventId);
            UpdateWins(info.EventId);
        }

        private static void FixPlacementPayout(string eventId) {
            // Go though every placement to update payouts
            //var reader = SqlUtil.Query("SELECT ID, RegionID, WeekID, Rank FROM Placement WHERE ID <> 1");
            Console.WriteLine("FixPlacementPayout for " + eventId);

                var reader = Db.Query("SELECT ID, RegionID, EventID, Rank FROM Placement WHERE ID <> 1 AND EventID = " + eventId);
            while (reader.Read()) {
                var id = reader[0].ToString();
                var regionId = reader[1].ToString();
                //var weekId = reader[2].ToString();
                var rank = (int)reader[3];

                int payout = 0;
                var tiers = Db.Query("SELECT Rank, Payout FROM RankPayoutTier WHERE RegionID = " + regionId + " AND EventID = " + eventId + " ORDER BY Rank DESC");
                while (tiers.Read()) {
                    var tierRank = (int)tiers[0];
                    var tierPayout = (int)tiers[1];

                    // Add points if they hit the tier
                    if (rank <= tierRank)
                        payout = tierPayout;
                }
                tiers.Close();

                Db.Command("UPDATE Placement SET Payout = " + payout.ToString() + " WHERE ID = " + id);
                //Thread.Sleep(1);
            }
        }

        private static void FixPlacementElims(string eventId) {

            Console.WriteLine("FixPlacementElims for " + eventId);

            // Go though ever placement to update elims
            // var reader = SqlUtil.Query("SELECT ID, RegionID, WeekID, Rank FROM Placement WHERE ID <> 1");
            var reader = Db.Query("SELECT ID, RegionID, EventID, Rank FROM Placement WHERE ID <> 1 AND EventID = " + eventId);
            while (reader.Read()) {
                var id = reader[0].ToString();
                //var regionId = reader[1].ToString();
                //var eventId = reader[2].ToString();

                // Games for each placement
                var games = Db.Query("SELECT GameRank, Elims FROM Game WHERE PlacementID = " + id + " ORDER BY EndTime");
                var elims = 0;
                while (games.Read()) {

                    elims += (int)games[1];

                    //var rank = (int)reader[0];

                    // Get the tiers (could do once)
                    //var tiers = SqlUtil.Query("SELECT Rank, Points FROM RankPointTier WHERE RegionID = " + regionId + " AND WeekID = " + weekId + " ORDER BY Rank DESC");
                    //while (tiers.Read()) {
                    //    var tierRank = (int)tiers[0];
                    //    var tierPoints = (int)tiers[1];

                    // Add points if they hit the tier
                    //     if (rank <= tierRank)
                    //        totalPoints += tierPoints;
                    //}
                }
                games.Close();
                //if (totalPoints > 0)
                Db.Command("UPDATE Placement SET Elims = " + elims.ToString() + " WHERE ID = " + id);
                Thread.Sleep(3);
            }
        }

        private static void UpdateWins(string eventId) {

            Console.WriteLine("UpdateWins for " + eventId);

            //var reader = SqlUtil.Query("SELECT ID FROM Placement WHERE ID <> 1");
            var reader = Db.Query("SELECT ID FROM Placement WHERE ID <> 1  AND EventID = " + eventId);
            while (reader.Read()) {
                var id = reader[0].ToString();

                int wins = 0;
                var games = Db.Query("SELECT GameRank FROM Game WHERE PlacementID = " + id + " ORDER BY EndTime");
                while (games.Read()) {
                    var gameRank = (int)games[0];

                    if (gameRank == 1)
                        wins++;
                }
                games.Close();

                Db.Command("UPDATE Placement SET Wins = " + wins.ToString() + " WHERE ID = " + id);
                //Thread.Sleep(1);
            }
        }   


        public static void FixPlayerRegions() {

            Console.WriteLine("FixPlayerRegions");

            // PlayerRegionView can have multiple regions per player; that's ok, the last one updated will have the most $
            var reader = Db.Query("SELECT PlayerID, RegionID, Payout FROM PlayerRegionView ORDER BY PlayerID, Payout ASC");
            while (reader.Read()) {
                var playerId = reader[0].ToString();
                var regionId = reader[1].ToString();

                Db.Command("UPDATE Player SET RegionID = " + regionId + " WHERE ID = " + playerId);
            }
        }



        public static void UpdatePlacementPowerPoints() {
            Console.WriteLine("Fix power points");

            var powerRankings = new PowerRankings();
            int count = 0;

            var reader = Db.Query("SELECT ID, Region, Event, Rank FROM StatsView WHERE Event IN (SELECT Name FROM PowerRankingEventsView)  ");
            while (reader.Read()) {
                string id = reader["ID"].ToString();
                string region = reader["Region"].ToString();
                string anEvent = reader["Event"].ToString();
                int rank = (int)reader["Rank"];
                                
                double pr = powerRankings.GetRanking(anEvent, region, rank);
                Db.Command("UPDATE Placement SET PowerPoints = " + pr.ToString() + " WHERE ID = " + id);

                count++;
                if ((count % 1000) == 0)
                    Console.WriteLine(count.ToString());
            }
        }

        public static void UpdatePlayerPowerPoints() {
            Console.WriteLine("Update player power points");

            var powerRankings = new PowerRankings();
            
            //var reader = Db.Query("SELECT DISTINCT PlayerID FROM StatsView WHERE SoloOrDuo = 'Squad'"); -- Only picks up players with money
            //var reader = Db.Query("SELECT PlayerID FROM PlayerPlacementView WHERE Event = 'CS Squads #1'");
            var reader = Db.Query("SELECT DISTINCT PlayerID FROM PlayerPlacementView"); // WHERE Event = 'CS Squads #1'");
            var players = 0;
            while (reader.Read()) {
                string playerId = reader["PlayerId"].ToString();
                double totalPoints = 0.0;

                var placements = Db.Query("SELECT RawPowerPoints, Event FROM StatsView WHERE PlayerID = " + playerId);
                while (placements.Read()) {
                    Double points = Convert.ToDouble(placements["RawPowerPoints"]) * powerRankings.GetWeekWeight(placements["Event"].ToString());
                    totalPoints += Math.Floor(points); 
                }
                placements.Close();

                Db.Command("UPDATE Player SET PowerPoints = " + totalPoints.ToString() + " WHERE ID = " + playerId);

                if (players % 1000 == 0)
                    Console.WriteLine(players.ToString());
                //Console.WriteLine(playerId + " " + totalPoints.ToString());

                players++;
            }
        }


        public static void FixPlayerNames() {
            //var reader = Db.Query("SELECT PlayerID, Max(EventID) EventID FROM PlayerEvent GROUP BY PlayerID, PlayerName");
            var reader = Db.Query("SELECT PlayerID, Max(PlacementID) PlacementID FROM PlayerPlacement GROUP BY PlayerID, Player ORDER BY PlacementID");
            var x = 0;
            while (reader.Read()) {
                string playerId = reader["PlayerID"].ToString();
                string placementId = reader["PlacementID"].ToString();

                // UPDATE
                Db.Command("UPDATE Player SET CurrentName = (SELECT Player FROM PlayerPlacement WHERE PlayerID = " + playerId + " AND PlacementID = " + placementId + ") WHERE ID = " + playerId);
                
                x++;
                if (x % 100 == 0)
                    Console.WriteLine(x.ToString());
            }
        }

        public static void ImportPlayerSearch() {

            string file = "c:\\project\\fortnite\\csv\\Analytics All Web Site Data Searches by Player and Date 20191104-20191123.csv";
            //string file = "c:\\project\\fortnite\\csv\\Players 20191014-20191020.csv";

            var csv = GetCsvParser(file);
            // Ignore header row
            csv.ReadFields();

            while (!csv.EndOfData) {
                string[] fields = csv.ReadFields();

                Db.Command("INSERT INTO PlayerSearch VALUES (" +
                    fields[0] + ",'" +
                    fields[1] + "'," +
                    fields[2] + "," +
                    fields[3] + ")"
                );

                Console.WriteLine(fields[0]);
            }
        }
            

        private static TextFieldParser GetCsvParser(string csvFile) {
            TextFieldParser csv = new TextFieldParser(csvFile, Encoding.UTF8);
            csv.CommentTokens = new string[] { "#" };
            csv.SetDelimiters(new string[] { "," });
            csv.HasFieldsEnclosedInQuotes = true;

            return csv;
        }


        public static string GetRegion(string code) {
            var regionId = "0";
            switch (code) {
                case "NAE":
                    regionId = "3";
                    break;
                case "NAW":
                    regionId = "4";
                    break;
                case "EU":
                    regionId = "5";
                    break;
                case "OCE":
                    regionId = "2";
                    break;
                case "ASIA":
                    regionId = "7";
                    break;
                case "BR":
                    regionId = "6";
                    break;
            }
            if (regionId == "0")
                throw new Exception("HI");

            return regionId;
        }


        // NOT USED

        public static void FixQualifications() {
            int i = 0;
            var reader = Db.Query("SELECT DISTINCT p.ID, pl1.RegionCode, pl1.WeekNumber " +
                " FROM Player p " +
                " JOIN Fortnite..Player p1 ON p.CurrentName = p1.Name " +
                " JOIN Fortnite..Placement pl1 ON pl1.PlayerID = p1.ID " +
                //"WHERE pl1.Qualification = 1");
                "WHERE pl1.EarnedQualification = 1");

            var inserts = new List<string>(); 
            while (reader.Read()) {
                var playerId = reader[0].ToString();
                var weekId = reader[2].ToString().Replace("Week", "");
                var regionId = GetRegion((string)reader[1]);

                var reader2 = Db.Query("SELECT PlacementID FROM PlayerPlacementView WHERE RegionID = " +
                    regionId + " AND WeekID = " + weekId + " AND PlayerID = " + playerId);
                if (reader2.Read()) {
                    var placementId = reader2[0].ToString();

                    var cmd = "UPDATE Placement SET EarnedQualification = 1 WHERE ID = " + placementId;
                    inserts.Add(cmd);
                    Db.Command(cmd);
                }
                i++;
            }
            System.IO.File.WriteAllLines("c:\\Test\\Inserts.txt", inserts);
            Console.WriteLine(i.ToString());
        }

        public static void UpdateWorldCupRegions() {
            var reader = Db.Query("SELECT PlacementID, PlayerID FROM PlayerPlacementView WHERE Event IN('Solo Final', 'Duo Final')");

            while (reader.Read()) {
                var placementId = reader["PlacementID"].ToString();
                var playerId = reader["PlayerID"].ToString();

                var reader2 = Db.Query("SELECT RegionID, Count(*) RegionCount FROM PlayerPlacementView WHERE PlayerID = " + playerId + " GROUP BY RegionID ORDER BY RegionCount DESC");
                reader2.Read();
                var regionId = reader2["RegionID"].ToString();

                var cmd = "UPDATE Placement SET RegionID = " + regionId + " WHERE ID = " + placementId;
                Db.Command(cmd);
            }
        }



        public static void AddPlayerPlacementNames() {
            int i = 0;
            var reader = Db.Query("SELECT DISTINCT PlayerID, EventID, RegionID, PlayerName, PlayerPlacementID FROM UpdateNameView");

            while (reader.Read()) {
                var playerPlacementId = reader["PlayerPlacementID"].ToString();
                //var playerId = reader["PlayerID"].ToString();
                //var eventId = reader["EventID"].ToString();
                //var regionId = reader["RegionID"].ToString();
                var name = reader["PlayerName"].ToString().Replace("'", "''");

                var cmd = "UPDATE PlayerPlacement SET Player = N'" + name + "' WHERE ID = " + playerPlacementId;
                Db.Command(cmd);
                
                i++;
                if (i % 1000 == 0)
                    Console.WriteLine(i.ToString());
            }            
        }
    }
}
