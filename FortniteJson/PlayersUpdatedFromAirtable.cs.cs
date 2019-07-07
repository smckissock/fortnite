using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualBasic.FileIO;

namespace FortniteJson {

    class PlayersUpdatedFromAirtable {
        static string path = "c:\\fortnite\\airtable\\";
        static string date = "2019 07 07 3";

        static List<string> teams;

        public static void Import() {
            //SqlUtil.Command("TRUNCATE TABLE AirtablePlayer");

            teams = GetTeams();
            ImportCsv();
            LinkPlacementsToPlayers();

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

            var name = fields[0];
            var age = fields[5];
            var twitter = fields[6];

            var nationality = fields[3];
            var team = fields[2];
            var kbmOrController = fields[4];

            // Insert Team if neccessary
            if (!teams.Contains(team)) {
                SqlUtil.Command("INSERT INTO Team VALUES ('" + team + "')");
                teams.Add(team);
            }

            // Update player fields using the player name as key
            var sql =
                "UPDATE Player SET " +
                "Age = '" + age + "', " +
                "Twitter = '" + twitter + "', " +

                "NationalityID = (SELECT ID FROM Nationality WHERE Name = '" + nationality + "'), " +
                "TeamID = (SELECT ID FROM Team WHERE Name = '" + team + "'), " +
                "KbmOrControllerID = (SELECT ID FROM KbmOrController WHERE Name = '" + kbmOrController + "') " +
                "WHERE Name = N'" + name + "'"; 

            SqlUtil.Command(sql);
        }

        private static void LinkPlacementsToPlayers() {
            SqlUtil.Command("UPDATE Placement SET PlayerID = " +
                "(SELECT ID FROM Player WHERE PLacement.Player = Player.Name)");
        }

        private static List<string> GetTeams() {
            teams = new List<string>();
            var reader = SqlUtil.Query("SELECT Name FROM Team");
            while (reader.Read()) 
                teams.Add(reader[0].ToString());

            return teams;
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
