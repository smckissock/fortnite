using System;
using System.Collections.Generic;
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



    public class EventFactor {

        private string anEvent;
        private string region;
        private int rank;
        private int payout;
        private int powerRankingPoints;

    }


    // 1.0 for most recent (highest Index), 0.98 for next, etc
    class WeekWeight {
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
            var reader = SqlUtil.Query("SELECT ID, WeekIndex  FROM Week ORDER BY WeekIndex DESC");
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

        public string RegionCode;
        public string EventName;

        PowerRankingPoints() {
        }


        //public static List<EventWeight> GetEventWeights() {
        //    var eventWeights = new List<EventWeight>();

        //    return eventWeights;
        //}
    }


    public class PowerRankings {

        private static List<WeekWeight> WeekWeights;

        private static Dictionary<string, PowerRankingPoints> dict = new Dictionary<string, PowerRankingPoints>();

        private List<string> events = new List<string>();
        private List<string> regions = new List<string>();

        public PowerRankings() {

            var reader = SqlUtil.Query("SELECT MAX(WeekIndex) FROM Week");
                reader.Read();
                int lastWeekIndex = (int)reader[0];
            WeekWeights = WeekWeight.GetWeekWeights(lastWeekIndex);

            events = SqlUtil.GetNames("Event");     
            regions = SqlUtil.GetNames("Region");
            

            foreach (string anEvent in events) {
                foreach (string region in regions) {

                    int rank = 0;
                    int payout = 0;
                    var rdr = SqlUtil.Query("SELECT Event, Region, Rank, Payout FROM PayoutTierView WHERE Event = '" + anEvent + "' AND Region = '" + region + "' ORDER BY Rank");
                    while (rdr.Read()) {
                        var tierRank = (int)rdr["Rank"];
                        var tierPayout = (int)rdr["Payout"];

                        // Add points if they hit the tier
                        if (rank <= tierRank)
                            payout = tierPayout;
                    }
                }
            }
        }

        public double GetRanking(string anEvent, string region, int place) {
            return 1.0;
        }
    }
}

