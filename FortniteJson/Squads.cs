using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace FortniteJson {

    class SquadInfo {
        public string PlacementId;
        public string RegionId;
        public string PlayerId;
        public string PlayerNum;
    }

    public class Squads {

        // 2035 CS Squads #1
        public static void Update(string eventId) {
            AddSquads(eventId);
        }

        public static void MakeSquadCsvs() {
            string path = @"c:\project\fortnite\r\champion-series-squads\data\";

            var lines = new List<string>();
            var header = @"Wk 1, wk 2, Wk 3, Avg,Avg Power Points,#1 Points,#1,#2 Points,#2,#3 Points,#3,#4 Points,#4";
            lines.Add(header);

            //var reader = Db.Query("SELECT Region, AveragePowerPoints, PowerPoints1, Player1, PowerPoints2, Player2, PowerPoints3, Player3, PowerPoints4, Player4 FROM SquadView ORDER BY Region");
            var reader = Db.Query("SELECT Region, W1Rank, W2Rank, W3Rank, AverageRank, AveragePowerPoints, PowerPoints1, Player1, PowerPoints2, Player2, PowerPoints3, Player3, PowerPoints4, Player4 FROM SquadStatsView ORDER BY Region");
            var oldRegion = "";
            var region = "X";
            while (reader.Read()) {
                region = reader["Region"].ToString();
                if (oldRegion != region) {
                    if (oldRegion != "")
                        File.WriteAllText(path + oldRegion + ".csv", string.Join("\n", lines));

                    lines = new List<string>();
                    lines.Add(header);
                    oldRegion = region;
                }

                var fields = new List<string>();

                fields.Add(FormatNum(Convert.ToDouble(reader["W1Rank"])));
                fields.Add(FormatNum(Convert.ToDouble(reader["W2Rank"])));
                fields.Add(FormatNum(Convert.ToDouble(reader["W3Rank"])));
                fields.Add(FormatNum(Convert.ToDouble(reader["AverageRank"])));

                fields.Add(FormatNum(Convert.ToDouble(reader["AveragePowerPoints"])));

                fields.Add(reader["PowerPoints1"].ToString());
                fields.Add(reader["player1"].ToString());

                fields.Add(reader["PowerPoints2"].ToString());
                fields.Add(reader["player2"].ToString());

                fields.Add(reader["PowerPoints3"].ToString());
                fields.Add(reader["player3"].ToString());

                fields.Add(reader["PowerPoints4"].ToString());
                fields.Add(reader["player4"].ToString());
                
                lines.Add("\"" + string.Join("\",\"", fields) + "\"");
            }
            File.WriteAllText(path + region + ".csv", string.Join("\n", lines));
        }


        // Takes 2323.22 and returns "2,323" 
        private static string FormatNum(double num) {
            int formatted = Convert.ToInt32(num);
            string x = String.Format("{0:n0}", formatted);
            return x;
        }



        private static void AddSquads(string eventId) {

            var squadDict = Db.Dictionary("Squad", "Hash");
           
            var player1Id = "";
            var player2Id = "";
            var player3Id = "";
            var player4Id = "";
            
            var rdr = Db.Query("SELECT PlacementID, RegionID, PlayerID, PlayerNum FROM PlayerPlacementIdView WHERE EventID = " + eventId + " ORDER BY PLacementID, PlayerNum");
            var squadInfos = new List<SquadInfo>();
            while (rdr.Read()) {
                var squad = new SquadInfo(); 
                squad.PlacementId = rdr["PlacementID"].ToString();
                squad.RegionId = rdr["RegionID"].ToString();
                squad.PlayerId = rdr["PlayerID"].ToString();
                squad.PlayerNum = rdr["PlayerNum"].ToString();
                squadInfos.Add(squad);
            }

            int placementCount = 0;
            foreach(SquadInfo squad in squadInfos) {
                SqlConnection.ClearAllPools();
                switch (squad.PlayerNum) {
                    case "1": player1Id = squad.PlayerId; break;
                    case "2": player2Id = squad.PlayerId; break;
                    case "3": player3Id = squad.PlayerId; break;
                    case "4":
                        player4Id = squad.PlayerId;

                        if ((player1Id == "") | (player2Id == "") | (player3Id == "") | (player4Id == ""))
                            throw new Exception("Missing PlayerIDs!");

                        string hash = player1Id + " " + player2Id + " " + player3Id + " " + player4Id;

                        var squadId = 0;
                        squadDict.TryGetValue(hash, out squadId);

                        // Found a new Squad
                        if (squadId == 0) {
                            Db.Command("INSERT INTO Squad VALUES (" + squad.RegionId + ", '" + hash + "')");
                            squadId = Db.Int("SELECT MAX(ID) FROM Squad");
                            squadDict.Add(hash, squadId);

                            Db.Command("INSERT INTO SquadPlayer VALUES (" + squadId.ToString() + "," + player1Id + ")");
                            Db.Command("INSERT INTO SquadPlayer VALUES (" + squadId.ToString() + "," + player2Id + ")");
                            Db.Command("INSERT INTO SquadPlayer VALUES (" + squadId.ToString() + "," + player3Id + ")");
                            Db.Command("INSERT INTO SquadPlayer VALUES (" + squadId.ToString() + "," + player4Id + ")");
                        }
                        placementCount++;
                        if (placementCount % 100 == 0)
                            Console.WriteLine(placementCount.ToString());

                        Db.Command("INSERT INTO SquadPlacement VALUES (" + squadId.ToString() + "," + squad.PlacementId + ")");
                        break;
                }
            }
        }
    }
}
