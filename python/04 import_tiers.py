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


regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR"]
solo_weeks = ["1", "3", "5", "7", "9"]
duo_weeks = ["2", "4", "6", "8", "10"]

#weeks = solo_weeks
#duos_directory = ''

weeks = duo_weeks
duos_directory = 'duos\\'


match = "OnlineOpen"
# match = "CashCup_Trios1"
event = "Event2"

for region in regions:
    print(region)
    for week in weeks:  # duo_weeks
        # Only need the first page for this - the tiers for the whole week/region
        for page in range(0, 1):
            fileName = region + "_Week" + str(week) + "_" + str(page) + ".html"
            try:
                file = open(
                    "c:\\fortnite-scrape\\scraped\\worldcup\\" + duos_directory + fileName, encoding="utf-8")
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

            insert_payout_tiers(doc[1]["payoutTable"][0]["ranks"],
                                doc[1]["scoringRules"][0]["rewardTiers"],
                                week, region)

val = input("Done")
