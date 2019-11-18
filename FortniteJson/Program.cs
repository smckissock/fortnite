using System;


namespace FortniteJson {

    class Program {

        static void Main(string[] args) {

            Console.WriteLine("Running..");

            //var directory = "champion series squad week 3 sat";
            var directory = "champion series squad week 3";
            var eventId = "2037";

            //Scraper.Step1_GetFiles(directory);
            //Scraper.Step2_GetPlayersAndPlayerWeeks(directory);
            //Scraper.Step3_ImportLeaderboard(directory);
            //Scraper.Step4_ImportTiers(directory);

            //Fortnite2FixUp.FixPayoutElimsAndWins(eventId);

            // update PowerRankings() current weekId  
            // Update PowerRnakingEventsView 
            Fortnite2FixUp.UpdatePlayerPowerPoints();   
            Fortnite2FixUp.UpdatePlacementPowerPoints();            

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
