﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FortniteJson {

    class Program {

        static void Main(string[] args) {

            //PlayersFromAirtableCsv.Import();
            //PlayersFromCsv.Import();

            Console.Write("Running..");

            //PlayersUpdatedFromAirtable.Import();

            Fortnite.MakeJson();


            Console.Write("DONE");
            Console.Read();


            // Not needed - make it in browser.
            //Fortnite.MakeCsv();
        }
    }
}
