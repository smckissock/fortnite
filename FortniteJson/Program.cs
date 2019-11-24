using System;
using System.Collections.Generic;


namespace FortniteJson {

    public class ImportInfo {
        public string Directory;
        public string EventId;
        public string Match;

        public List<string> Events;
        public List<string> EventNames; 
        public int Pages;
        public int MinimumPlacement;
    }
    


    class Program {

        static void Main(string[] args) {

            // All data governing import goes here
            var info = new ImportInfo();

            info.Directory = "champion series squad week 3 sat";
            info.EventId = "2037";                                  // 2035 = squad week 1
            info.Match = "S11_FNCS_Week3";
            info.Events = new List<string> { "Event2" };            // Typically Sunday is Event3, Saturday is 1 & 2 
            info.EventNames = new List<string> { "CS Squads #3" };  // Name for Event.Name, ex: CS Squads #1
            info.Pages = 6;                                         // Number of scraped pages to import
            info.MinimumPlacement = 26;                             // Importer will not insert placement records for placements less than this


            Console.WriteLine("Running..");

            //var directory = "champion series squad week 3 sat";
            //var directory = "champion series squad week 3";
            //var eventId = "2037";

            //Scraper.Step1_GetFiles(directory);
            //Scraper.Step2_GetPlayersAndPlayerWeeks(info);
            //Scraper.Step3_ImportLeaderboard(info);
            //Scraper.Step4_ImportTiers(info);

            //Fortnite2FixUp.FixPayoutElimsAndWins(info);

            // update PowerRankings() current weekId  
            //Fortnite2FixUp.UpdatePlayerPowerPoints();   
            //Fortnite2FixUp.UpdatePlacementPowerPoints();            



            //Fortnite2FixUp.AddPlayerPlacementNames();
            //Fortnite2FixUp.FixPlayerNames();

            Fortnite.MakeDimensions();
            Fortnite.MakeJsonArray();   


            //Fortnite2FixUp.ImportPlayerSearch();


            //Squads.Update("2037");
            Squads.MakeSquadCsvs(); // For R tables

            Console.Write("DONE");
            Console.Read();



            // DO NOT RUN THIS.  IT GIVES WC PLACEMENTS (REGION 1) THE REGION OF THE PLAYER 
            //Fortnite2FixUp.FixPlayerRegions();
        }
    }
}
