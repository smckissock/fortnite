import requests
import json
import time


from db import cmd, cursor, conn, max_id


def insert_placement(placement, week, region):
    points_earned = placement["pointsEarned"]
    rank = placement["rank"]

    # Insert Placement record
    try:
        cursor.execute("INSERT INTO Placement (WeekID, RegionID, Rank, Points) VALUES ( " +
                       "?, (SELECT ID FROM Region WHERE EpicCode = ?), ?, ?)", week, region, rank, points_earned)

        conn.commit()
    # Should never happen
    except Exception as e:
        pass

    # Update PlayerPlacement records [1..4] with the ID of the placement just added
    for member_guid in placement["teamAccountIds"]:
        try:
            cursor.execute(
                "INSERT INTO Player VALUES (?, '', 1, 1, 1, '', '')", member_guid)
            conn.commit()
        except Exception as e:
            pass

        try:
            cursor.execute("INSERT INTO PlayerWeek VALUES ((SELECT ID FROM Player WHERE EpicGuid = ?), ?, " +
                           "(SELECT ID FROM Region WHERE EpicCode = ?), ?)",
                           member_guid, 12, 'TBD', "?")
            conn.commit()
        except Exception as e:
            pass

        try:
            cursor.execute("INSERT INTO PlayerPlacement VALUES((SELECT ID FROM Player WHERE EpicGuid= ?), " +
                           "(SELECT MAX(ID) FROM Placement))", member_guid, )
            conn.commit()
        # Should never happen
        except Exception as e:
            pass

    # Add games
    for game in placement["sessionHistory"]:
        end_time = game["endTime"]
        stats = game["trackedStats"]

        # Doesn't seem to exist for first two weeks
        seconds_alive = 0
        try:
            seconds_alive = stats["TIME_ALIVE_STAT"]
        # Could happen!
        except Exception as e:
            pass

        game_rank = stats["PLACEMENT_STAT_INDEX"]
        elims = stats["TEAM_ELIMS_STAT_INDEX"]
        tiebreaker = stats["PLACEMENT_TIEBREAKER_STAT"]

        try:
            cursor.execute("INSERT INTO Game VALUES( (SELECT MAX(ID) FROM Placement), ?, ?, ?, ?, ?)",
                           end_time, seconds_alive, game_rank, elims, tiebreaker)
            conn.commit()
        # Should never happen
        except Exception as e:
            pass


file = open(
    "c:\\fortnite-scrape\\scraped\\worldcup\\solos\\solos.html", encoding="utf-8")

html = file.read()

firstChar = html.find("var imp_leaderboard = {") + 22
lastChar = html.find("</script>", firstChar) - 1
json_text = html[firstChar:lastChar]

# Accounts section in json
try:
    doc = json.loads(json_text)
except Exception as e:
    print(json_text)
    exit()

for placement in doc["entries"]:
    insert_placement(placement, "12", "TBD")

exit()

regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR"]
solo_weeks = ["1", "3", "5", "7", "9"]
duo_weeks = ["2", "4", "6", "8", "10"]

#weeks = solo_weeks
#last_page = 31
#duos_directory = ''

weeks = duo_weeks
last_page = 16
duos_directory = 'duos\\'


match = "OnlineOpen"
# match = "CashCup_Trios1"
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