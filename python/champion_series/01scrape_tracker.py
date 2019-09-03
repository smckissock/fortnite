# Download all champion cup trio html files from FTN

import requests
import time
from bs4 import BeautifulSoup

from db import cmd, cursor, conn, max_id


regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR", "ME"]
weeks = ["Week3"]

# Fortnitw Champion Series
match = "S10_FNCS"
event = "Event3"

# Looking for this:
# https://fortnitetracker.com/events/epicgames_S10_FNCS_Week1_NAE?window=S10_FNCS_Week1_NAE_Event3&page=0

print("Start")


for region in regions:
    print(region)
    for week in weeks:
        for page in range(0, 21):

            # Import Trios
            url = "https://fortnitetracker.com/events/epicgames_" + match + "_" + \
                week + "_" + region + "?window=" + match + "_" + week + "_" + region + \
                "_" + event + "&page=" + str(page)

            response = requests.get(url)
            f = open("d:\\fortnite\\fortnite-scrape\\champion-series\\" + region + "_" + week +
                     "_" + str(page) + ".html", "w+", encoding="utf-8")
            f.write(response.text)
            f.close()

        time.sleep(3)
print("Done")
