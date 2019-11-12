using System;


namespace FortniteJson {

    class Program {

        static void Main(string[] args) {

            Console.WriteLine("Running..");

            var directory = "champion series squad week 2";
            var eventId = "2036";

            //Scraper.Step1_GetFiles(directory);
            //Scraper.Step2_GetPlayersAndPlayerWeeks(directory);
            //Scraper.Step3_ImportLeaderboard(directory);
            //Scraper.Step4_ImportTiers(directory);

            //Fortnite2FixUp.FixPlacementPayout(eventId);  
            //Fortnite2FixUp.FixPlacementElims(eventId);
            //Fortnite2FixUp.UpdateWins(eventId);

                      
            Fortnite2FixUp.UpdatePlayerPowerPoints(); // Player
            Fortnite2FixUp.FixPowerPoints();            // Placement

            //Fortnite2FixUp.AddPlayerPlacementNames();
            //Fortnite2FixUp.FixPlayerNames();

            Fortnite.MakeDimensions();

            Fortnite.MakeJsonArray();   


            //Fortnite2FixUp.ImportPlayerSearch();


            //Squads.Update("2035");
            //Squads.MakeSquadCsvs(); // For R tables

            Console.Write("DONE");
            Console.Read();



            // DO NOT RUN THIS.  IT GIVES WC PLACEMENTS (REGION 1) THE REGION OF THE PLAYER 
            //Fortnite2FixUp.FixPlayerRegions();
        }
    }
}
