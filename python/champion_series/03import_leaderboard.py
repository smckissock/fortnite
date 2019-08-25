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


regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR", "ME"]
weeks = ["1"]
last_page = 21

for region in regions:
    print(region)
    for week in weeks: 
        for page in range(0, last_page): 
            print(page)
            fileName = region + "_Week" + str(week) + "_" + str(page) + ".html"
            try:
                file = open(
                    "d:\\fortnite\\fortnite-scrape\\champion-series\\" + fileName, encoding="utf-8")
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
                insert_placement(placement, "13", region)

val = input("Done")
