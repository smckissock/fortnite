﻿using System;


namespace FortniteJson {

    class Program {

        static void Main(string[] args) {

            //PlayersFromAirtableCsv.Import();
            //PlayersFromCsv.Import();

            //Python.Run(@"c:\fortnite\python\scrape_tracker_trios.py", "");
            //Python.Run(@"c:\fortnite\python\import_tracker.py", "");
            
            //Fortnite2FixUp.FixCurrentName();
            //Fortnite2FixUp.FixPlacementPayout();
            //Fortnite2FixUp.FixPlacementElims();
            //Fortnite2FixUp.UpdateWins();

            Console.WriteLine("Running..");

            //Fortnite2FixUp.FixQualifications();

            //PlayersUpdatedFromAirtable.Import();
            //Fortnite.MakeJson();

            Fortnite.MakeJsonArray();

            //Fortnite.MakeCsv();

            Console.Write("DONE");
            Console.Read();



            // Not needed - make it in browser.
            
        }
    }
}
