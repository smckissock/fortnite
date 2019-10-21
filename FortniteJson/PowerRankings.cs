using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FortniteJson {
    

    public static class PowerRankingParams {
        // Increase this to make older results matter less
        public static double WeekWeightPercentageDropPerWeek = 0.02;

        // For Current, should be most recent week (MAX WeekIndex)
        public static int AsOfWeekX;
    }
    
    // 1.0 for most recent (highest Index), 0.98 for next, etc
    public class WeekWeight {
        public int Id;
        public int Index;
        public double Weight;

        WeekWeight(int id, int index, double weight) {
            Id = id;
            Index = index;
            Weight = weight;
        }

        public static List<WeekWeight> GetWeekWeights(int weekIndex) {
            var weekWeights = new List<WeekWeight>();
            var reader = Db.Query("SELECT ID, WeekIndex FROM Week ORDER BY WeekIndex DESC");
            int count = 0;
            while (reader.Read()) {
                // e.g. 1.0, 0.98, 0.96...
                double weight = 1 - count * PowerRankingParams.WeekWeightPercentageDropPerWeek;

                weekWeights.Add(new WeekWeight(
                    (int)reader["ID"],
                    (int)reader["WeekIndex"],
                    weight)
                );
                count++;
            }
            return weekWeights;
        }
    }


    public class PowerRankingPoints {

        public string Match;
        public int TeamSize;
        public string Region;
        public string EventName;
        public int Rank;
        public int Payout;

        public double WeekFactor;
        public double PlacementPoints;
        public double PowerPoints;

        public PowerRankingPoints(string match, int teamSize, string region, string eventName, int rank, int payout) {
            Match = match;
            TeamSize = teamSize;
            Region = region;
            EventName = eventName;
            Rank = rank;
            Payout = payout;
        }

        public string HashCode() {
            return Region + EventName + Rank.ToString();
        }

        public void Print() {
            Console.WriteLine(Region + " " + EventName + " " + Rank.ToString() + " " + Payout + " " + WeekFactor.ToString() + " " + PlacementPoints.ToString() + " " + PowerPoints.ToString());
        }
    }


    public class PowerRankings {

        private static List<WeekWeight> weekWeights;

        private static Dictionary<string, PowerRankingPoints> pointsDict = new Dictionary<string, PowerRankingPoints>();
        private static Dictionary<string, double> weekWeightingDict = new Dictionary<string, double>();

        private List<string> events = new List<string>();
        private List<string> regions = new List<string>();

        // Call this to get Power Ranking Points. DOES NOT INCLUDE WEEK FACTOR    
        public Double GetRanking(string anEvent, string region, int place) {
            PowerRankingPoints pnts = pointsDict[region + anEvent + place.ToString()];
            return pnts.PowerPoints;
        }

        private static string CsvLine(string match, int teamSize, string anEvent, string region, int rank, int payout, string points) {

            string format = ""; 
            switch (teamSize) {
                case 1: format = "Solos"; break;
                case 2: format = "Duos"; break;
                case 3: format = "Trios"; break;
                case 4: format = "Squads"; break;
                default: format = "ERROR"; break;
            }       

            return 
                match + "," +
                format + "," +
                //anEvent + "," +
                ((anEvent.Contains("WC Week") && anEvent != "WC Week 10") ? " " + anEvent : anEvent) + "," +
                region + "," +
                rank.ToString() + "," +
                payout.ToString() + "," +
                points;
        }


        public PowerRankings() {

            weekWeights = WeekWeight.GetWeekWeights(Db.Int("SELECT MAX(WeekIndex) FROM Week"));

            //events = Db.Names("Event");
            events = Db.Names("PowerRankingEventsView");  // Just WC and FCS
            regions = Db.Names("Region");

            // Setup dictionary to look up the weighting for each event, based on the week
            var weekReader = Db.Query("SELECT Name, WeekID FROM Event");
            while (weekReader.Read()) {
                var anEvent = weekReader["Name"].ToString();
                var weekId = (int)weekReader["WeekID"];

                var factor = weekWeights.Find(x => x.Index == weekId);
                weekWeightingDict.Add(anEvent, factor.Weight);
            }

            // For csv file
            var header = "\"Match\",\"Format\",\"Event\",\"Region\",\"Rank\",\"Payout\",\"Points\"";
            var lines = new List<string>();
            lines.Add(header);

            
            foreach (string anEvent in events) {
                foreach (string region in regions) {
                    int totalPayout = 0;
                    
                    // if (anEvent == "CS Week 2" && region == "NA East")
                    //     Console.Write("X");
                    
                    // Add Power Ranking Points with event, region, place, and payout
                    PowerRankingPoints powerRankingPoints;
                    int rank = 1;
                    var rdr = Db.Query("SELECT Match, Event, Region, Rank, Payout, TeamSize FROM PayoutTierView WHERE Event = '" + anEvent + "' AND Region = '" + region + "' ORDER BY Rank");
                    while (rdr.Read()) {
                        var match = (string)rdr["Match"];
                        var tierRank = (int)rdr["Rank"];
                        var payout = (int)rdr["Payout"];
                        var teamSize = (int)rdr["TeamSize"];  // 1, 2, 3, or 4

                        if (rank == 1) {
                            totalPayout += payout; // * teamSize;  
                            powerRankingPoints = new PowerRankingPoints(match, teamSize, region, anEvent, rank, payout);
                            pointsDict.Add(powerRankingPoints.HashCode(), powerRankingPoints);
                            rank = 2;
                        }
                        while (rank <= tierRank) {
                            totalPayout += payout; // * teamSize;
                            powerRankingPoints = new PowerRankingPoints(match, teamSize, region, anEvent, rank, payout);
                            pointsDict.Add(powerRankingPoints.HashCode(), powerRankingPoints);
                            rank++;
                        }
                    }

                    // Add WeekFactor, PlacementPoints, PowerPoints;
                    int ranks = rank - 1;
                    double weekFactor = weekWeightingDict[anEvent];

                    // This is 1 + 2 + 3..rank
                    double parts = (ranks / 2) * (ranks + 1);

                    double dollarsPerPart = totalPayout / parts;

                    // Divide World Cup winnings by 15 (Payout was 15 million not 1)
                    if (anEvent == "Solo Final" || anEvent == "Duo Final")
                        dollarsPerPart /= 15;

                    // Divide Champion Series winnings by 3 (Payout was 3 million not 1)
                    if (anEvent == "CS Final")
                        dollarsPerPart /= 3;

                    for (int i = 1; i <= ranks; i++) {
                        PowerRankingPoints pnts = pointsDict[region + anEvent + i.ToString()];

                        pnts.PlacementPoints = (ranks - i + 1) * dollarsPerPart;
                        pnts.WeekFactor = weekFactor;

                        // pnts.PowerPoints = pnts.PlacementPoints * pnts.WeekFactor;
                        pnts.PowerPoints = pnts.PlacementPoints;  // Multiply by week factor in browser

                        lines.Add(CsvLine(pnts.Match, pnts.TeamSize, anEvent, region, i, pnts.Payout, pnts.PowerPoints.ToString()));
                    }

                    Console.WriteLine(anEvent + " " + region + " Total = " + totalPayout + " Count = " + (rank - 1));
                }
            }
            string fileName = @"c:\project\fortnite\r\power-ranking-tiers\data.csv";
            File.WriteAllText(fileName, string.Join("\n", lines));

            Console.WriteLine(pointsDict.Count.ToString() + " items");
        }
    }
}

