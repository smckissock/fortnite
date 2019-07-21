using System;


namespace FortniteJson {

    class Program {

        static void Main(string[] args) {

            //PlayersFromAirtableCsv.Import();
            //PlayersFromCsv.Import();

            //Python.Run(@"c:\fortnite\python\scrape_tracker_trios.py", "");
            //Python.Run(@"c:\fortnite\python\import_tracker.py", "");

            Console.WriteLine("Running..");

            //Fortnite2FixUp.FixCurrentName();
            //Fortnite2FixUp.FixPlacementPayout();
            //Fortnite2FixUp.FixPlacementElims();
            //Fortnite2FixUp.UpdateWins();

            PlayersUpdatedFromAirtable.Import();
            //Fortnite.MakeJson();

            Console.Write("DONE");
            Console.Read();



            // Not needed - make it in browser.
            //Fortnite.MakeCsv();
        }
    }
}
