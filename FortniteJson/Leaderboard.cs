using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace FortniteJson {

    public class Leaderboard {

        // Make a csv for each region with player data
        public static void SquadTest() {

            string path = @"c:\project\fortnite\r\champion-series-squads\data\";

            List<string> lines = new List<string>();
            var header = "\"Region\",\"Player\",\"Payout\",\"RawPowerPoints\"";

            int playersPerRegion = 1000; 
            int count = 0;
            var region = "";
            //var reader = Db.Query("SELECT Region, Player, Payout, RawPowerPoints FROM StatsWithPlayerInfoView WHERE Region <> 'All' ORDER BY Region, Payout");

            var reader = Db.Query("SELECT Region, Player, Payout, PowerPoints FROM SquadTestView ORDER BY Region, Payout DESC");

            while (reader.Read()) {
                string newRegion = reader["Region"].ToString();
                if (newRegion != region) {
                    if (region != "")
                        File.WriteAllText(path + region + ".csv", string.Join("\n", lines));

                    lines.Clear();
                    lines.Add(header);
                    region = newRegion;
                    count = 0;
                }

                var fields = new List<string>();
                fields.Add(reader["Region"].ToString());
                fields.Add(reader["Player"].ToString());
                fields.Add(reader["Payout"].ToString());
                fields.Add(reader["PowerPoints"].ToString());

                if (count < playersPerRegion) {
                    lines.Add("\"" + string.Join("\",\"", fields) + "\"");
                    Console.WriteLine(reader["Player"].ToString());
                }

                count++;
            }

            File.WriteAllText(path + region + ".csv", string.Join("\n", lines));
        }
    }
}
