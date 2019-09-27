using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualBasic.FileIO;

namespace FortniteJson {

    class PlayersUpdatedFromAirtable {
        static string path = "c:\\fortnite\\airtable\\";
        static string date = "2019 07 26";

        static List<string> teams;

        public static void Import() {
            //SqlUtil.Command("TRUNCATE TABLE AirtablePlayer");

            teams = GetTeams();
            ImportCsv();
            //LinkPlacementsToPlayers();
        }

        private static void ImportCsv() {
            var csv = GetCsvParser(path + date + "\\Players.csv");
            // Ignore header row
            csv.ReadLine();

            while (!csv.EndOfData) {
                string[] fields = csv.ReadFields();
                UpdatePlayer(fields);
            }

            Db.Command("INSERT INTO AirtableUpdate SELECT * FROM AirtableUpdateView");
        }

        private static void UpdatePlayer(string[] fields) {
            var vals = new List<string>();

            var name = fields[0];
            var age = fields[5];
            var twitter = fields[6];

            var nationality = fields[3];
            var team = fields[2];
            var kbmOrController = fields[4];

            // Insert Team if neccessary
            if (!teams.Contains(team)) {
                Db.Command("INSERT INTO Team VALUES ('" + team.Replace("'", "''") + "')");
                teams.Add(team);
            }

            // Update player fields using the player name as key
            var sql =
                "UPDATE Player SET " +
                "Age = '" + age + "', " +
                "Twitter = '" + twitter + "', " +

                "NationalityID = (SELECT ID FROM Nationality WHERE Name = '" + nationality + "'), " +
                "TeamID = (SELECT ID FROM Team WHERE Name = '" + team.Replace("'", "''") + "'), " +
                "KbmOrControllerID = (SELECT ID FROM KbmOrController WHERE Name = '" + kbmOrController + "') " +
                "WHERE CurrentName = N'" + name + "'"; 

            Db.Command(sql);
        }

        private static void LinkPlacementsToPlayers() {
            Db.Command("UPDATE Placement SET PlayerID = " +
                "(SELECT ID FROM Player WHERE Placement.Player = Player.Name)");
        }

        private static List<string> GetTeams() {
            teams = new List<string>();
            var reader = Db.Query("SELECT Name FROM Team");
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
