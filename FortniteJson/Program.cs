using System;


namespace FortniteJson {

    class Program {

        static void Main(string[] args) {

            //PlayersFromAirtableCsv.Import();
            //PlayersFromCsv.Import();

            //Python.Run(@"c:\fortnite\python\scrape_tracker_trios.py", "");
            //Python.Run(@"c:\fortnite\python\import_tracker.py", "");
            
            //Fortnite2FixUp.FixCurrentName();
            
            
            //Fortnite2FixUp.FixQualifications();

            Console.WriteLine("Running..");

            //Python.Run(@"c:\fortnite\python\02import_wc_duo_player_playerWeek", "");

            //Python.Run(@"c:\fortnite\python\03import_wc_duo_loaderboard.py", "");

            //PlayersUpdatedFromAirtable.Import();

            // For World Cup Finals
            //Fortnite.MakeGames();


            // Steps for Trio Follow: Update Week and Week ID in Python code


            //Python.Run(@"c:\project\fortnite\python\champion_series\01scrape_tracker.py", ""); 
            //Python.Run(@"c:\project\fortnite\python\champion_series\02import_player_playerWeek.py", "");
            //Python.Run(@"c:\project\fortnite\python\champion_series\03import_leaderboard.py", "");
            //Python.Run(@"c:\project\fortnite\python\champion_series\04import_tiers.py", "");

            // These all need to filter their queries to only update the latest week.  Otherwise it take 20 minutes
            //Fortnite2FixUp.FixPlacementPayout();
            //Fortnite2FixUp.FixPlacementElims();
            //Fortnite2FixUp.UpdateWins();
                
            // Prior step wipes out Finals payouts. Rerun 03 Payouts for Finals.sql to put them back (or add a week filter)  

            //var directory = "champion-series";
            //var directory = "Cash Cup Wed";
            //var directory = "Cash Cup Thurs";
            var directory = "champion-series-final";

            //Scraper.Step1_GetFiles(directory);
            //Scraper.Step2_GetPlayersAndPlayerWeeks(directory);
            //Scraper.Step3_ImportLeaderboard(directory);
            //Scraper.Step4_ImportTiers(directory);

            //Fortnite2FixUp.UpdateWorldCupRegions();


            // MAKE SURE TO UPDATE WEEK BEFORE RUNNING THIS
            // Wed 1019 1020 1021 1022
            // Thurs 1025 1026 1027 1028
            // Fri 1031 1032 1033 1034
            //Fortnite2FixUp.FixPlacementPayout("1035");
            //Fortnite2FixUp.FixPlacementElims("1035");
            //Fortnite2FixUp.UpdateWins("1035");

            //Fortnite2FixUp.ImportPlayerSearch();

            Leaderboard.SquadTest();

            //Fortnite2FixUp.FixPlayerNames();

            //Fortnite2FixUp.FixPlayerRegions();

            //Fortnite2FixUp.FixPowerPoints();
            //Fortnite2FixUp.AddPlayerPlacementNames();

            //Fortnite.MakeDimensions();
            //Fortnite.MakeJsonArray();   

            Console.Write("DONE");
            Console.Read();

            //Fortnite.MakeCsv();

            // Not needed - make it in browser.
            
        }
    }
}
