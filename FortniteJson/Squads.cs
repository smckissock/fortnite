using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FortniteJson {

    public class Squads {

        // 2035 CS Squads #1
        public static void Update(string eventId) {
            AddSquads(eventId);
            AddPlayers(eventId);
            AddPlacements(eventId);
        }

        public static void MakeSquadCsvs() {
            string path = @"c:\project\fortnite\r\champion-series-squads\data\";

            var lines = new List<string>();
            var header = @"Avg Power Points,#1 Points,#1,#2 Points,#2,#3 Points,#3,#4 Points,#4";
            lines.Add(header);

            var reader = Db.Query("SELECT Region, AveragePowerPoints, PowerPoints1, Player1, PowerPoints2, Player2, PowerPoints3, Player3, PowerPoints4, Player4 FROM SquadView ORDER BY Region");
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
            var squadId = "";
            var oldPlacementId = "";
            var rdr = Db.Query("SELECT ID, RegionID, PlayerID FROM PlacementView WHERE EventID = " + eventId + " ORDER BY ID");
            while (rdr.Read()) {
                var placementId = rdr["ID"].ToString();
                var regionId = rdr["RegionID"].ToString();
                var playerId = rdr["PlayerID"].ToString();

                if (placementId != oldPlacementId) {
                    Db.Command("INSERT INTO Squad VALUES (" + regionId +")");
                    squadId = Db.Int("SELECT MAX(ID) FROM Squad").ToString();

                    Db.Command("INSERT INTO SquadPlacement VALUES (" + squadId + "," + placementId + ")");

                    oldPlacementId = placementId;
                }
                Db.Command("INSERT INTO SquadPlayer VALUES (" + squadId + "," + playerId + ")");
            }
        }

        private static void AddPlayers(string eventId) {

        }

        private static void AddPlacements(string eventId) {

        }
    }
}
