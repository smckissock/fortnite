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
        //private static string weekId = "18"; // UPDATE EACH WEEK

        // Contenders Solo - Wednesday 
        //private static string match = "S10_CC_Contenders";
        //private static List<string> events = new List<string>   { "Event1", "Event2", "Event3", "Event4" };  
        //private static List<string> eventNames = new List<string>   { "CC Wednesday #1", "CC Wednesday #2", "CC Wednesday #3", "CC Wednesday #4" };  

        // Contenders Solo - Thursday 
        //private static string match = "S10_CC_Champions";
        // private static List<string> events = new List<string> { "Event1", "Event2", "Event3", "Event4" }; 
        //private static List<string> eventNames = new List<string> { "CC Thursday #1", "CC Thursday #2", "CC Thursday #3", "CC Thursday #4" };  

        // Contenders Solo - Friday 
        //private static string match = "S10_CC_Trios";
        //private static List<string> events = new List<string> { "Event1", "Event2", "Event3", "Event4" };  
        //private static List<string> eventNames = new List<string> { "CC Friday #1", "CC Friday #2", "CC Friday #3", "CC Friday #4" };

        // Champion Series Final 
        private static string match = "S11_FNCS_Week3";
        //private static List<string> events = new List<string> { "Event2" };  // Saturday
        private static List<string> events = new List<string> { "Event3" };  // Sunday
        private static List<string> eventNames = new List<string> { "CS Squads #3" }; // My name from Event.Name: CS Squads #1

        private static int pages = 1;


        public static void Step1_GetFiles(string directory) {
            foreach (string region in regions) {
                //foreach (string week in weeks) {
                foreach (string anEvent in events) {
                    for (int i = 0; i < pages; i++) {
                        string page = i.ToString(); 
                        string html = string.Empty;

                        // Champion Series
                        //string url = @"https://fortnitetracker.com/events/epicgames_" + match + "_" + week + "_" + region + "?window=" +
                        //    match + "_" + week + "_" + region + "_" + theEvent + "&page=" + page;

                        // Cash Cup 
                        var path = match + "_" + region;

                        var realEvent = anEvent; 
                        //if ((region == "ME") || (region == "OCE") || (region == "ASIA"))
                        //    realEvent = "Event3";

                        string url = @"https://fortnitetracker.com/events/epicgames_" + path + "?window=" + path + "_" + realEvent + "&page=" + page;
                        //string url = @"https://fortnitetracker.com/events/epicgames_" + path;
                        Console.WriteLine(url);

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


        // Looks at the section of imp_accounts array, which has Epic accounts the names that players used for the week. 
        // Inserts new players (just Epic ID)
        // Inserts a PlayerEvent Record
        public static void Step2_GetPlayersAndPlayerWeeks(string directory) {
            foreach (string region in regions) {
                Console.WriteLine(region);
                for (int eventNum = 0; eventNum < events.Count; eventNum++) {
                    string epicEvent = events[eventNum];
                    string myEvent = eventNames[eventNum];

                    for (int i = 0; i < pages; i++) {
                        string page = i.ToString();

                        string fileName = @"d:\\fortnite\\fortnite-scrape\\" + directory + "\\" + region + "_" + epicEvent + "_" + page + ".html";
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
                                                 
                            Db.Command("INSERT INTO Player VALUES('" + player.accountId + "', '', 1, 1, 1, '', '', (SELECT ID FROM Region WHERE EpicCode = '" + region + "'))");
                            
                            Db.Command("INSERT INTO PlayerEvent VALUES((SELECT ID FROM Player WHERE EpicGuid = '" + player.accountId + "'), (SELECT ID FROM Event WHERE Name = '" + myEvent + "'), " +
                                "(SELECT ID FROM Region WHERE EpicCode = '" + region + "'), N'" + player.playerName + "')");
                        }
                    }
                }
            }
        }

        public static void Step3_ImportLeaderboard(string directory) {
            foreach (string region in regions) {
                Console.WriteLine(region);
                for (int eventNum = 0; eventNum < events.Count; eventNum++) {
                    string epicEvent = events[eventNum];
                    string myEvent = eventNames[eventNum];

                    for (int i = 0; i < pages; i++) {
                        string page = i.ToString();

                        string fileName = @"d:\fortnite\fortnite-scrape\" + directory + "\\" + region + "_" + epicEvent + "_" + page + ".html";
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
                            Step3_InsertPlacement(placement, myEvent, region);
                    }
                }
            }
        }

        private static void Step3_InsertPlacement(dynamic placement, string myEvent, string region) {
            Db.Command("INSERT INTO Placement (EventID, RegionID, Rank, Points) VALUES ((SELECT ID FROM Event WHERE Name = '" + myEvent + "'), (SELECT ID FROM Region WHERE EpicCode = '" +
                region + "'), " + placement.rank + ", " + placement.pointsEarned + ")");

            // Placements have 1, 2 or 3 players attached 
            foreach (var accountGuid in placement.teamAccountIds) {
                Db.Command("INSERT INTO PlayerPlacement VALUES((SELECT ID FROM Player WHERE EpicGuid= '" + accountGuid + "'), " +
                    "(SELECT MAX(ID) FROM Placement), (SELECT PlayerName FROM LookupNameView WHERE EpicGuid= '" + accountGuid + "' AND EventName = '" + myEvent + "'))");
            }
         
            foreach (var game in placement.sessionHistory) {
                var stats = game.trackedStats;
                int secondsAlive = 0;
                try {
                    secondsAlive = stats.TIME_ALIVE_STAT;
                } catch { // Isn't always there - that's ok
                }

                Db.Command("INSERT INTO Game VALUES((SELECT MAX(ID) FROM Placement), '" + game.endTime + "', " + secondsAlive + ", " +
                    stats.PLACEMENT_STAT_INDEX + ", " + stats.TEAM_ELIMS_STAT_INDEX + ", " + stats.PLACEMENT_TIEBREAKER_STAT + ")");
            }
        }

        public static void Step4_ImportTiers(string directory) {
            foreach (string region in regions) {

                Console.WriteLine(region);
                for (int eventNum = 0; eventNum < events.Count; eventNum++) {
                    string epicEvent = events[eventNum];
                    string myEvent = eventNames[eventNum];

                    for (int i = 0; i < 1; i++) {
                        string page = i.ToString();

                        string fileName = @"d:\fortnite\fortnite-scrape\" + directory + "\\" + region + "_" + epicEvent + "_" + page + ".html";
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
                   
                        int round = 0; // round 3 // Or 2!!
                        Step4_InsertWeekRegionTiers(
                            json[round].payoutTable[0].ranks, // or 1!
                            json[round].scoringRules[0].rewardTiers,  // or 1
                            myEvent, region);
                    }
                }
            }
        }

        private static void Step4_InsertWeekRegionTiers(dynamic payoutTiers, dynamic scoringTiers, string myEvent, string region) {
            //Console.WriteLine(payoutTiers);
            //Console.WriteLine(scoringTiers);

            //foreach (var tier in payoutTiers) {
            //    var threshold = tier.threshold;
            //    var payout = tier.payouts[0].quantity;
            //    Db.Command("INSERT INTO RankPayoutTier (EventID, RegionID, Rank, Payout) VALUES (" +
            //        "(SELECT ID FROM Event WHERE Name = '" + myEvent + "'), (SELECT ID FROM Region WHERE EpicCode = '" + region + "')," + threshold + "," + payout + ")");
            //}

            foreach (var tier in scoringTiers) {
                var threshold = tier.keyValue;
                var points = tier.pointsEarned;
                Db.Command("INSERT INTO RankPointTier (EventID, RegionID, Rank, Points) VALUES (" +
                    "(SELECT ID FROM Event WHERE Name = '" + myEvent + "'), (SELECT ID FROM Region WHERE EpicCode = '" + region + "')," + threshold + "," + points + ")");
            }
        }
    }
}

