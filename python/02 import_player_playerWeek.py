# Using the html files from ftn, grab the impl_account section:
# 1) Populate the Player table, which is ID and Epic Guid
# 2) Add Placement records

import requests
import json
import re
import time
from bs4 import BeautifulSoup

from db import cmd, cursor, conn, max_id


def insert_player_guid(player, week_id, region_code):
    account_id = player.get("accountId")
    player = player.get("playerName")
    try:
        cursor.execute(
            "INSERT INTO Player VALUES (?, '', 1, 1, 1, '', '')", account_id)
        conn.commit()
    # There will duplicates here most of the time, that's normal
    except Exception as e:
        pass

    # Add PlayerPlacement with PlayerID (their Epic account) and the name they used this week.
    # PlacementID gets updated later using leaderboard
    try:
        cursor.execute("INSERT INTO PlayerWeek VALUES ((SELECT ID FROM Player WHERE EpicGuid = ?), ?, " +
                       "(SELECT ID FROM Region WHERE EpicCode = ?), ?)",
                       account_id, week_id, region_code, player)
        conn.commit()
    # Shouldn't happen, but does: in Week NAE, KNG Sebby placed 1339 with "jinFN on youtube" and 49 with Grove
    # Ignoring this should break anything...
    except Exception as e:
        pass


file = open(
    "c:\\fortnite-scrape\\scraped\\worldcup\\duos\\duos.html", encoding="utf-8")
html = file.read()

firstChar = html.find("var imp_accounts = [") + 18
lastChar = html.find("</script>", firstChar) - 1
json_text = html[firstChar:lastChar]
try:
    players = json.loads(json_text)
except Exception as e:
    print(json_text)
    exit()

for player in players:
    insert_player_guid(player, "11", "TBD")


exit()


regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR"]
solo_weeks = ["1", "3", "5", "7", "9"]
duo_weeks = ["2", "4", "6", "8", "10"]

weeks = solo_weeks
last_page = 31
duos_directory = ''

#weeks = duo_weeks
#last_page = 16
#duos_directory = 'duos\\'


match = "OnlineOpen"
#match = "CashCup_Trios1"
event = "Event2"

for region in regions:
    print(region)
    for week in weeks:  # duo_weeks
        for page in range(0, last_page):  # 16
            fileName = region + "_Week" + str(week) + "_" + str(page) + ".html"
            try:
                # "c:\\fortnite-scrape\\scraped\\worldcup\\duos\\"
                file = open(
                    "c:\\fortnite-scrape\\scraped\\worldcup\\" + duos_directory + fileName, encoding="utf-8")
            except Exception as e:
                continue

            html = file.read()

            # this is pages way of saying "no accounts" so skip it
            if html.find("var imp_accounts = null") > 0:
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
                insert_player_guid(player, week, region)

val = input("Done")
