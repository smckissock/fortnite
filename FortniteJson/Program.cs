using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FortniteJson {

    class Program {

        static void Main(string[] args) {

            //PlayersFromAirtableCsv.Import();
            //PlayersFromCsv.Import();

            //PlayersUpdatedFromAirtable.Import();


            Fortnite.MakeJson();
            
            
            // Not needed - make it in browser.
            //Fortnite.MakeCsv();
        }
    }
}
