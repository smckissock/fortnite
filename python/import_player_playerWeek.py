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
        cursor.execute("INSERT INTO Player VALUES (?)", account_id)
        conn.commit()
        # There will duplicates here most of the time, that's normal
    except Exception as e:
        pass

    #cursor.execute("SELECT ID FROM Player WHERE EpicGuid = ?", accountId)
    #rows = cursor.fetchall()
    #player_id = rows[0].ID

    cursor.execute("INSERT INTO PlayerWeek (PlayerID, WeekID, RegionID, Name) VALUES ( " +
                   "(SELECT ID FROM Player WHERE EpicGuid = ?), ?, " +
                   "(SELECT ID FROM Region WHERE EpicCode = ?), ?)", account_id, week_id, region_code, player)
    conn.commit()


regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR"]
solo_weeks = ["1", "3", "5", "7", "9"]
duo_weeks = ["2", "4", "6", "8", "10"]

match = "OnlineOpen"
#match = "CashCup_Trios1"
event = "Event2"

for region in regions:
    print(region)
    for week in solo_weeks:  # duo_weeks
        for page in range(1, 31):  # 16
            fileName = region + "_Week" + str(week) + "_" + str(page) + ".html"
            try:
                # "c:\\fortnite-scrape\\scraped\\worldcup\\duos\\"
                file = open(
                    "c:\\fortnite-scrape\\scraped\\worldcup\\" + fileName, encoding="utf-8")
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
