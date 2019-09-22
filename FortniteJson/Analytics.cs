using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Net;
using Newtonsoft.Json;

using System.Net.Http;


namespace FortniteJson {

    public class DateRange {
        public string startDate;
        public string endDate;
        public DateRange (string startDate, string endDate) {
            this.startDate = startDate;
            this.endDate = endDate;
        }
        public List<DateRange> DateRanges() {
            var ranges = new List<DateRange>();
            ranges.Add(this);
            return ranges;
        }
    }

    public class Metric {
        public string expression;
        public Metric(string value) {
            this.expression = value;
        }
        public List<Metric> Metrics() {
            var metrics = new List<Metric>();
            metrics.Add(this);
            return metrics;
        }
    }

    public class ReportRequest {
        public string viewId;
        public List<DateRange> dateRanges;
        public List<Metric> metrics;
    }

    public class Batch {
        public List<ReportRequest> reportRequests;
    }

    public class Analytics {

        //POST https://analyticsreporting.googleapis.com/v4/reports:batchGet
        //{
        //    "reportRequests":
        //    [
        //        {
        //            "viewId": "XXXX",
        //            "dateRanges": [{"startDate": "2014-11-01", "endDate": "2014-11-30"}],
        //            "metrics": [{"expression": "ga:users"}]
        //        }
        //    ]
        //}

        public static void GetStats() {

            var batch = new Batch();
            var reportRequests = new List<ReportRequest>();
            batch.reportRequests = reportRequests;

            var reportRequest = new ReportRequest();
            reportRequest.viewId = "196155669";
            reportRequest.dateRanges = new DateRange("2019-08-01", "yesterday").DateRanges();
            reportRequest.metrics = new Metric("ga: users").Metrics(); // "[{\"expression\": \"ga:users\"}]";

            reportRequests.Add(reportRequest);

            string json = JsonConvert.SerializeObject(batch);
            var niceJson = Newtonsoft.Json.Linq.JToken.Parse(json).ToString();
            Console.Write(niceJson);

            string url = "https://analyticsreporting.googleapis.com/v4/reports:batchGet";

            getData(url, json);
            return;


            HttpClient client = new HttpClient();

            

            //var content = new FormUrlEncodedContent(batch);

            //var response = await client.PostAsync(url, niceJson);
            //var response = client.Post(url, niceJson);

            //return;

            //var responseString = await response.Content.ReadAsStringAsync();

            //HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            //request.AutomaticDecompression = DecompressionMethods.GZip;

            //using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            //using (Stream stream = response.GetResponseStream())

            //using (StreamReader reader = new StreamReader(stream)) {
            //    var jsonResponse = reader.ReadToEnd();
            //    //string fileName = @"d:\\fortnite\\fortnite-scrape\\champion-series\\" + region + "_" + week + "_" + page + ".html";
            //    //System.IO.File.WriteAllText(fileName, html);
            //}
        }

        private static void getData(string url, string json) {
            var request = (HttpWebRequest)WebRequest.Create(url);

            //var postData = "thing1=" + Uri.EscapeDataString("hello");
            //postData += "&thing2=" + Uri.EscapeDataString("world");
            //var data = Encoding.ASCII.GetBytes(postData);

            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = json.Length;

            using (var stream = request.GetRequestStream()) {
                stream.Write(Encoding.ASCII.GetBytes(json), 0, json.Length);
            }

            var response = (HttpWebResponse)request.GetResponse();

            var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();

            Console.Write(responseString);
        }
    }
}
