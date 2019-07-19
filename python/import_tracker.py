import requests
import json
import re
import time
from bs4 import BeautifulSoup

from db import cmd, cursor, conn, max_id


def insert_player_guid(player):
    try:
        cursor.execute("INSERT INTO Player VALUES (?)",
                       player.get("accountId"))
        conn.commit()
    except Exception as e:
        pass
        # There will duplicates here most of the time, that's normal


regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR"]
solo_weeks = ["Week1", "Week3", "Week5", "Week7", "Week9"]
duo_weeks = ["Week2", "Week4", "Week6", "Week8", "Week10"]

match = "OnlineOpen"
#match = "CashCup_Trios1"
event = "Event2"

for region in regions:
    print(region)
    for week in duo_weeks:
        for page in range(1, 16):
            fileName = region + "_" + week + "_" + str(page) + ".html"
            try:
                # "c:\\fortnite-scrape\\scraped\\worldcup\\"
                file = open(
                    "c:\\fortnite-scrape\\scraped\\worldcup\\duos\\" + fileName, encoding="utf-8")
            except Exception as e:
                continue

            html = file.read()

            # this is pages way of saying "no accounts" so skip it
            if html.find("var imp_accounts = null"):
                continue

            firstChar = html.find("var imp_accounts = [") + 18
            lastChar = html.find("</script>", firstChar) - 1
            json_text = html[firstChar:lastChar]
            #print("X" + json_text + "X")

            # Accounts section in json
            try:
                players = json.loads(json_text)
            except Exception as e:
                print(json_text)
                exit()

            for player in players:
                insert_player_guid(player)

val = input("Done")
