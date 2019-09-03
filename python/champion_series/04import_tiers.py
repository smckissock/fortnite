import json
import time


from db import cmd, cursor, conn, max_id


def insert_payout_tiers(payoutTiers, scoringTiers, week, region):
    for tier in payoutTiers:
        threshold = tier["threshold"]
        payout = tier["payouts"][0]["quantity"]

        # Insert RankPayoutTier
        try:
            cursor.execute("INSERT INTO RankPayoutTier (WeekID, RegionID, Rank, Payout) VALUES ( " +
                           "?, (SELECT ID FROM Region WHERE EpicCode = ?), ?, ?)", week, region, threshold, payout)
            conn.commit()
        # Should never happen
        except Exception as e:
            pass

    # Insert RankPointTier ....
    for tier in scoringTiers:
        threshold = tier["keyValue"]
        points = tier["pointsEarned"]

        # Insert RankPayoutTier
        try:
            cursor.execute("INSERT INTO RankPointTier (WeekID, RegionID, Rank, Points) VALUES ( " +
                           "?, (SELECT ID FROM Region WHERE EpicCode = ?), ?, ?)", week, region, threshold, points)
            conn.commit()
        # Should never happen
        except Exception as e:
            pass


regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR", "ME"]


# UPDATE THESE TWO
weeks = ["3"]
week_id = "15"


for region in regions:
    print(region)
    for week in weeks:  
        # Only need the first page for this - the tiers for the whole week/region
        for page in range(0, 1):
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

            
            firstChar = html.find("var imp_templates = [") + 20
            lastChar = html.find("</script>", firstChar) - 1
            json_text = html[firstChar:lastChar]
            # print("X" + json_text + "X")

            # Accounts section in json
            try:
                doc = json.loads(json_text)
            except Exception as e:
                print(json_text)
                exit()

            # Watch out - the may change the structure of tiers 
            # Use http://jsonviewer.stack.hu/ to see json in tree view  
            round = 2 # round 3
            #week_id = "13"
            insert_payout_tiers(doc[round]["payoutTable"][1]["ranks"],
                                doc[round]["scoringRules"][1]["rewardTiers"],
                                week_id, region)

val = input("Done")
