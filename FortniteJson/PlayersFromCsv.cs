using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualBasic.FileIO;

namespace FortniteJson {

        
    public class PlayersFromCsv {
        static string path = "c:\\fortnite\\csv\\";
        static string date = "2019 07 02"; 

        static string soloName = "World Cup Qualified Players - Info & Stats - Solos.csv";
        static string duoName = "World Cup Qualified Players - Info & Stats - Duos.csv";


        public static void Import() {
            SqlUtil.Command("TRUNCATE TABLE PlayerInfo");

            ImportSolos();
            ImportDuos();
        }

        private static void ImportSolos() {
            var csv = GetCsvParser(path + date + "\\" + soloName);
            // Ignore header row
            csv.ReadLine();

            int[] cols = { 0, 1, 2, 3, 14, 5 };
            while (!csv.EndOfData) {
                string[] fields = csv.ReadFields();
                InsertPlayer(fields, cols, "1");
            }
        }

        private static void ImportDuos() {
            var csv = GetCsvParser(path + date + "\\" + duoName);
            // Ignore header row
            csv.ReadLine();

            int[] cols = { 0, 1, 2, 3, 5, 6 };
            int[] cols2 = { 0, 7, 8, 9, 11, 12 };
            while (!csv.EndOfData) {
                string[] fields = csv.ReadFields();

                InsertPlayer(fields, cols, "0");
                InsertPlayer(fields, cols2, "0");
            }
        }

        private static void InsertPlayer(string[] fields, int[] cols, string soloOrDuo) {
            var vals = new List<string>();
            foreach (int col in cols)
                vals.Add(fields[col]);

            var sqlFields = String.Join("', '", vals);
            SqlUtil.Command("INSERT INTO PlayerInfo VALUES ('" + sqlFields + "', " + soloOrDuo + ")");
        }

        private static TextFieldParser GetCsvParser(string csvFile) {
            TextFieldParser csv = new TextFieldParser(csvFile, Encoding.Default);
            csv.CommentTokens = new string[] { "#" };
            csv.SetDelimiters(new string[] { "," });
            csv.HasFieldsEnclosedInQuotes = true;

            return csv;
        }
    }
}
