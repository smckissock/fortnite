using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using Newtonsoft.Json;


namespace FortniteJson {
    class Scraper {

        private static List<string> regions = new List<string> { "NAE", "NAW", "EU", "OCE", "ASIA", "BR", "ME" };

        // Champion Series
        //private static List<string> weeks = new List<string> { "Week5" };  // UPDATE EACH WEEK
        //private static string match = "S10_FNCS";
        //private static string theEvent = "Event3";
        private static string weekId = "17"; // UPDATE EACH WEEK

        // Contenders Solo - Wednesday 
        private static List<string> weeks = new List<string> { "Week5" };  // UPDATE EACH WEEK
        //private static string match = "S10_CC_Contenders";
        //private static string match = "S10_CC_Champions";
        private static string match = "S10_CC_Trios";
        private static List<string> events = new List<string> { "Event1", "Event2", "Event3", "Event4" };  // UPDATE EACH WEEK
        //private static string weekId = "17"; // UPDATE EACH WEEK

        public static void Step1_GetFiles(string directory) {
            foreach (string region in regions) {
                //foreach (string week in weeks) {
                foreach (string anEvent in events) {
                    for (int i = 0; i < 20; i++) {
                        string page = i.ToString();
                        string html = string.Empty;

                        // Champion Series
                        //string url = @"https://fortnitetracker.com/events/epicgames_" + match + "_" + week + "_" + region + "?window=" +
                        //    match + "_" + week + "_" + region + "_" + theEvent + "&page=" + page;

                        // Cash Cup 
                        var path = match + "_" + region; 
                        string url = @"https://fortnitetracker.com/events/epicgames_" + path + "?window=" + path + "_" + anEvent + "&page=" + page;

                                                // https://fortnitetracker.com/events/epicgames/_S10_CC_Contenders_NAE?window=S10_CC_Contenders_NAE_anEvent&page=0


                        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                        request.AutomaticDecompression = DecompressionMethods.GZip;

                        using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                        using (Stream stream = response.GetResponseStream())
                        using (StreamReader reader = new StreamReader(stream)) {
                            html = reader.ReadToEnd();
                            string fileName = @"d:\\fortnite\\fortnite-scrape\\" + directory + "\\" + region + "_" + anEvent + "_" + page + ".html";
                            System.IO.File.WriteAllText(fileName, html);
                        }
                        System.Threading.Thread.Sleep(200);
                    }
                }
            }
        }

        public static void Step2_GetPlayersAndPlayerWeeks(string directory) {
            foreach (string region in regions) {
                foreach (string week in weeks) {
                    for (int i = 0; i < 50; i++) {
                        string page = i.ToString();

                        string fileName = @"d:\\fortnite\\fortnite-scrape\\champion-series\\" + region + "_" + week + "_" + page + ".html";
                        string html = "";
                        try {
                            html = System.IO.File.ReadAllText(fileName);
                        } catch {
                            //Console.WriteLine(fileName + " missing");
                            continue;
                        }

                        if (html.Contains("var imp_accounts = null")) {
                            //Console.WriteLine("No Accounts");
                            continue;
                        }

                        int firstChar = html.IndexOf("var imp_accounts = [") + 18;
                        int lastChar = html.IndexOf("</script>", firstChar) - 1;
                        string json_text = html.Substring(firstChar, lastChar - firstChar);

                        dynamic json = JsonConvert.DeserializeObject(json_text);
                        foreach (var player in json) {
                            SqlUtil.Command("INSERT INTO Player VALUES('" + player.accountId + "', '', 1, 1, 1, '', '')");

                            SqlUtil.Command("INSERT INTO PlayerWeek VALUES((SELECT ID FROM Player WHERE EpicGuid = '" + player.accountId + "'), " + weekId + ", " +
                                "(SELECT ID FROM Region WHERE EpicCode = '" + region + "'), '" + player.playerName + "')");
                        }
                    }
                }
            }
        }

        public static void Step3_ImportLeaderboard(string directory) {
            foreach (string region in regions) {
                foreach (string week in weeks) {
                    for (int i = 0; i < 50; i++) {
                        string page = i.ToString();

                        string fileName = @"d:\\fortnite\\fortnite-scrape\\champion-series\\" + region + "_" + week + "_" + page + ".html";
                        string html = "";
                        try {
                            html = System.IO.File.ReadAllText(fileName);
                        } catch {
                            //Console.WriteLine(fileName + " missing");
                            continue;
                        }

                        if (html.Contains("var imp_leaderboard = null"))
                            continue;

                        int firstChar = html.IndexOf("var imp_leaderboard = {") + 22;
                        int lastChar = html.IndexOf("</script>", firstChar) - 1;
                        string json_text = html.Substring(firstChar, lastChar - firstChar);

                        dynamic json = JsonConvert.DeserializeObject(json_text);
                        foreach (var placement in json.entries)
                            Step3_InsertPlacement(placement, weekId, region);
                    }
                }
            }
        }

        private static void Step3_InsertPlacement(dynamic placement, string weekId, string region) {
            SqlUtil.Command("INSERT INTO Placement (WeekID, RegionID, Rank, Points) VALUES (" + weekId + ", (SELECT ID FROM Region WHERE EpicCode = '" +
                region + "'), " + placement.rank + ", " + placement.pointsEarned + ")");

            // Placements have 1, 2 or 3 players attached 
            foreach (var accountGuid in placement.teamAccountIds) {
                SqlUtil.Command("INSERT INTO PlayerPlacement VALUES((SELECT ID FROM Player WHERE EpicGuid= '" + accountGuid + "'), " +
                    "(SELECT MAX(ID) FROM Placement))");
            }
         
            foreach (var game in placement.sessionHistory) {
                var stats = game.trackedStats;
                int secondsAlive = 0;
                try {
                    secondsAlive = stats.TIME_ALIVE_STAT;
                } catch { // Isn't always there - that's ok
                }

                SqlUtil.Command("INSERT INTO Game VALUES((SELECT MAX(ID) FROM Placement), '" + game.endTime + "', " + secondsAlive + ", " +
                    stats.PLACEMENT_STAT_INDEX + ", " + stats.TEAM_ELIMS_STAT_INDEX + ", " + stats.PLACEMENT_TIEBREAKER_STAT + ")");
            }
        }

        public static void Step4_ImportTiers(string directory) {
            foreach (string region in regions) {
                foreach (string week in weeks) {
                    for (int i = 0; i < 1; i++) {
                        string page = i.ToString();

                        string fileName = @"d:\\fortnite\\fortnite-scrape\\" + directory + "\\" + region + "_" + week + "_" + page + ".html";
                        string html = "";
                        try {
                            html = System.IO.File.ReadAllText(fileName);
                        } catch {
                            //Console.WriteLine(fileName + " missing");
                            continue;
                        }

                        if (html.Contains("var imp_leaderboard = null"))
                            continue;

                        int firstChar = html.IndexOf("var imp_templates = [") + 20;
                        int lastChar = html.IndexOf("</script>", firstChar) - 1;
                        string json_text = html.Substring(firstChar, lastChar - firstChar);

                        dynamic json = JsonConvert.DeserializeObject(json_text);
                        ;

                        int round = 2; // round 3 
                        Step4_InsertWeekRegionTiers(
                            json[round].payoutTable[1].ranks,
                            json[round].scoringRules[1].rewardTiers,
                            weekId, region);
                    }
                }
            }
        }

        private static void Step4_InsertWeekRegionTiers(dynamic payoutTiers, dynamic scoringTiers, string weekId, string region) {
            //Console.WriteLine(payoutTiers);
            //Console.WriteLine(scoringTiers);

            foreach (var tier in payoutTiers) {
                var threshold = tier.threshold;
                var payout = tier.payouts[0].quantity;
                SqlUtil.Command("INSERT INTO RankPayoutTier (WeekID, RegionID, Rank, Payout) VALUES (" +
                    weekId + ", (SELECT ID FROM Region WHERE EpicCode = '" + region + "')," + threshold + "," + payout + ")");
            }

            foreach (var tier in scoringTiers) {
                var threshold = tier.keyValue;
                var points = tier.pointsEarned;
                SqlUtil.Command("INSERT INTO RankPointTier (WeekID, RegionID, Rank, Points) VALUES (" +
                    weekId + ", (SELECT ID FROM Region WHERE EpicCode = '" + region + "')," + threshold + "," + points + ")");
            }
        }
    }
}

