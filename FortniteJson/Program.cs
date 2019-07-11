using System;


namespace FortniteJson {

    class Program {

        static void Main(string[] args) {

            //PlayersFromAirtableCsv.Import();
            //PlayersFromCsv.Import();




            Console.WriteLine("Running..");

            PlayersUpdatedFromAirtable.Import();
            Fortnite.MakeJson();

            Console.Write("DONE");
            Console.Read();





            // Not needed - make it in browser.
            //Fortnite.MakeCsv();
        }
    }
}
