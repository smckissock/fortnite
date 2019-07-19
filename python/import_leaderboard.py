import requests
import json
import time


from db import cmd, cursor, conn, max_id


def insert_placement(placement, week, region):
    points_earned = placement["pointsEarned"]
    rank = placement["rank"]

    for member_guid in placement["teamAccountIds"]:
        try:
            cursor.execute("UPDATE PlayerWeek SET Points = ?, Rank = ? WHERE " +
                           "PlayerID = (SELECT ID FROM Player WHERE EpicGuid = ?) AND " +
                           "WeekID = ? AND RegionID = (SELECT ID FROM Region WHERE EpicCode = ?)",
                           points_earned, rank, member_guid, week, region)
            conn.commit()
        except Exception as e:
            pass

        # for game in

        # "PLACEMENT_STAT_INDEX": 1,
        # "TIME_ALIVE_STAT": 1373,
        # "TEAM_ELIMS_STAT_INDEX": 19,
        # "MATCH_PLAYED_STAT": 1,
        # "PLACEMENT_TIEBREAKER_STAT": 99,

    # cursor.execute("INSERT INTO PlayerWeek (PlayerID, WeekID, RegionID, Name) VALUES ( " +
    #               "(SELECT ID FROM Player WHERE EpicGuid = ?), ?, " +
    #              "(SELECT ID FROM Region WHERE EpicCode = ?), ?)", account_id, week_id, region_code, player)
    # conn.commit()


regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR"]
solo_weeks = ["1", "3", "5", "7", "9"]
duo_weeks = ["2", "4", "6", "8", "10"]

match = "OnlineOpen"
# match = "CashCup_Trios1"
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
            if html.find("var imp_leaderboard = null") > 0:
                continue

            firstChar = html.find("var imp_leaderboard = {") + 22
            lastChar = html.find("</script>", firstChar) - 1
            json_text = html[firstChar:lastChar]
            # print("X" + json_text + "X")

            # Accounts section in json
            try:
                doc = json.loads(json_text)
            except Exception as e:
                print(json_text)
                exit()

            for placement in doc["entries"]:
                insert_placement(placement, week, region)

val = input("Done")
