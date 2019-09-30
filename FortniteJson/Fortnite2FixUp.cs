using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;



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

        public static void FixPlacementPayout(string eventId) {
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

        public static void FixPlacementElims(string eventId) {

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

        public static void UpdateWins(string eventId) {

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



        public static void FixPowerPoints() {
            Console.WriteLine("Fix power points");

            var powerRankings = new PowerRankings();
            int count = 0;

            var reader = Db.Query("SELECT ID, Region, Event, Rank FROM StatsWithPlayerInfoView");
            while (reader.Read()) {
                string id = reader["ID"].ToString();
                string region = reader["Region"].ToString();
                string anEvent = reader["Event"].ToString();
                int rank = (int)reader["Rank"];

                // For some reason, there are not RankPayoutTier records for world cup solo or duo (Good thing we aren't using them anyway...
                //if (anEvent != "Solo Final" && anEvent != "Duo Final") {
                    double pr = powerRankings.GetRanking(anEvent, region, rank);
                    Db.Command("UPDATE Placement SET PowerPoints = " + pr.ToString() + " WHERE ID = " + id);
                //}

                count++;
                if ((count % 1000) == 0)
                    Console.WriteLine(count.ToString());
            }
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
    }
}
