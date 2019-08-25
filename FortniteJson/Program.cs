﻿using System;


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

            //Python.Run(@"c:\project\fortnite\python\champion_series\02import_player_playerWeek.py", "");
            //Python.Run(@"c:\project\fortnite\python\champion_series\03import_leaderboard.py", "");
            //Python.Run(@"c:\project\fortnite\python\champion_series\04import_tiers.py", "");

            //Fortnite2FixUp.FixPlacementPayout();
            //Fortnite2FixUp.FixPlacementElims();
            //Fortnite2FixUp.UpdateWins();

            Fortnite.MakeJsonArray();
            

            Console.Write("DONE");
            Console.Read();

            //Fortnite.MakeCsv();

            // Not needed - make it in browser.
            
        }
    }
}
