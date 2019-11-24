using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;



namespace FortniteJson {

    public class Db {

        //static string sqlErrorPath = @"C:\Fortnite\FortniteJson\Sql Error\";

        static string db = "Fortnite";

        //private static string connectionString = "Server=SCOTT-PC\\SQLExpress;Database=" + db + ";Trusted_Connection=True;";
        //private static string connectionString =   "Server=PC\\SQLExpress;Database=" + db + ";Trusted_Connection=True;";
        private static string connectionString = "Server=DESKTOP-S1K43CL\\SQLEXPRESS;Database=" + db + ";Trusted_Connection=True;";

        private string ForR = "Server=DESKTOP-S1K43CL\\SQLEXPRESS;Database=Fortnite;Trusted_Connection=True;";

        public static SqlDataReader Query(string sql) {
            SqlDataReader reader = null;
            using (SqlCommand command = new SqlConnection(connectionString).CreateCommand()) {
                command.CommandText = sql.Replace("''''", "''"); // if they doubled the ticks twice
                try {
                    command.Connection.Open();
                    reader = command.ExecuteReader(CommandBehavior.CloseConnection);
                }
                catch (Exception ex) {
                    ex.Data.Add("SQL", sql + " SQL ERROR: " + ex.Message);
                    command.Connection.Close();
                    throw ex;
                }
                return reader;
            }
        }

        
        public static bool Command(string sql) {
            using (SqlCommand command = new SqlConnection(connectionString).CreateCommand()) {
                command.CommandText = sql.Replace("''''", "''"); // if they doubled the ticks twice
                try {
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                    return true;
                }
                catch (Exception ex) {
                    ex.Data.Add("SQL", sql + " SQL ERROR: " + ex.Message);

                    // Log and keep going...
                    //using (TextWriter tw = new StreamWriter(sqlErrorPath + DateTime.Now.ToString("yyyyMMddHHmmss") + ".txt")) {
                    //    foreach (DictionaryEntry data in ex.Data)
                    //        tw.WriteLine(data.Key + ": " + data.Value);
                    
                    command.Connection.Close();
                    return false;
                }
            }
        }

        public static void StoredProcedure(string storedProcedure) {
            using (var conn = new SqlConnection(connectionString)) {
                using (var command = new SqlCommand(storedProcedure, conn) {
                    CommandType = CommandType.StoredProcedure
                }) {
                    conn.Open();
                    command.CommandTimeout = 600;
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
            }
        }

        /// <summary>
        /// Returns Names in tables, in order
        /// </summary>
        public static List<string> Names(string table) {
            var rdr = Db.Query("SELECT Name FROM " + table + " WHERE Name <> 'TBD' ORDER BY Name DESC");
            var names = new List<string>();
            while (rdr.Read())
                names.Add(rdr["Name"].ToString());

            return names;
        }


        /// <summary>
        /// Get first fields of first record as an int 
        /// </summary>
        public static int Int(string sql) {
            var reader = Db.Query(sql);
            reader.Read();
            int result = (int)reader[0];

            // Read a second time (and fail)  This will close the connection!
            reader.Read();

            return result;
        }


        /// <summary>
        ///  Returns a Dictionary if keys and IDs for table 
        /// </summary>
        public static Dictionary<string, int> Dictionary(string table, string key){
            var dict = new Dictionary<string, int>();

            var reader = Db.Query("SELECT " + key + ", ID FROM " + table);
            while (reader.Read())
                dict.Add(reader[0].ToString(), (int)reader[1]);

            return dict;
        }
    }
}
