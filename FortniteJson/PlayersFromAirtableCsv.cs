using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualBasic.FileIO;

namespace FortniteJson {

    class PlayersFromAirtableCsv {

        static string path = "c:\\fortnite\\airtable\\";
        static string date = "2019 07 07";

        public static void Import() {
            SqlUtil.Command("TRUNCATE TABLE AirtablePlayer");

            ImportCsv();

            Console.Write("DONE");
            Console.Read();
        }

        private static void ImportCsv() {
            var csv = GetCsvParser(path + date + "\\Players.csv");
            // Ignore header row
            csv.ReadLine();

            while (!csv.EndOfData) {
                string[] fields = csv.ReadFields();
                InsertPlayer(fields);
            }
        }

        private static void InsertPlayer(string[] fields) {
            var vals = new List<string>();
            for (int col = 0; col < 8; col++)
                vals.Add(fields[col]);

            var sqlFields = String.Join("', N'", vals);
            SqlUtil.Command("INSERT INTO AirtablePlayer VALUES (N'" + sqlFields + "')");
        }

        private static TextFieldParser GetCsvParser(string csvFile) {
            TextFieldParser csv = new TextFieldParser(csvFile, Encoding.UTF8);
            csv.CommentTokens = new string[] { "#" };
            csv.SetDelimiters(new string[] { "," });
            csv.HasFieldsEnclosedInQuotes = true;

            return csv;
        }
    }
}
