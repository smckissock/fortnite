using System;


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
            //Fortnite.MakeJson();
            //Fortnite2FixUp.FixQualifications();

            Console.WriteLine("Running..");

            //PlayersUpdatedFromAirtable.Import();
            Fortnite.MakeJsonArray();


            Console.Write("DONE");
            Console.Read();

            //Fortnite.MakeCsv();

            // Not needed - make it in browser.
            
        }
    }
}
