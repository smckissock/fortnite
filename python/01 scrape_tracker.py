# Download all world cup and trio gtml files from FTN


import requests
import time
from bs4 import BeautifulSoup

from db import cmd, cursor, conn, max_id


def insert_placement(week, solo_or_duo, name, region, rank, payout, points):
    print("x")
    # cursor.execute("INSERT INTO Placement VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", \
    #    week, solo_or_duo, name, region, rank, payout, points, False, False)
    # conn.commit()


def insert_stats(point_breakdown):
    print("x")
    #placement_id = max_id('Placement')

    # for k, v in point_breakdown.items():
    #    stat_index = k
    #    points_earned = v.get('pointsEarned')
    #    times_achieved =  v.get('timesAchieved')

    #    cursor.execute("INSERT INTO Stat VALUES (?, ?, ?, ?)", \
    #        placement_id, stat_index, points_earned, times_achieved)
    #    conn.commit()


def save_places(json, week, region, solo_or_duo):
    try:
        """ for place in json.get("entries"):

            if place is None:
                print("No Place!!")

            try:    
                rank = place.get("rank")
                points = place.get("pointsEarned")
                payout = 0
                if place.get('payout') is not None:
                    payout = place.get('payout').get('quantity') 
            except Exception as e:
                print(str(e))    

            display_names =  place.get("displayNames")

            if display_names is None:
                print("No display names")

            name1 = ""
            if display_names[0] is not None:
                name1 = display_names[0]

            # Insert first player (or only player if it is solo)    
            insert_placement(week, solo_or_duo, name1, region, rank, payout, points)
            insert_stats(place.get("pointBreakdown"))

            # duo
            if solo_or_duo == 'Duo':  
                name2 = ''
                if len(display_names) > 1:
                    if display_names[1] is not None:
                        name2 = display_names[1] 

                insert_placement(week, solo_or_duo, name2, region, rank, payout, points)
                insert_stats(place.get("pointBreakdown")) """

    except Exception as e:
        print('Error inserting Place PLAYER1=' + str(e))


regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR"]
solo_weeks = ["Week1", "Week3", "Week5", "Week7", "Week9"]
duo_weeks = ["Week2", "Week4", "Week6", "Week8", "Week10"]

match = "OnlineOpen"
#match = "CashCup_Trios1"
event = "Event2"

for region in regions:
    for week in solo_weeks:
        for page in range(0, 1):

            # Import Solos
            #      https://fortnitetracker.com/events/epicgames_OnlineOpen_Week1_NAE?window=OnlineOpen_Week1_NAE_Event2&page=1
            url = "https://fortnitetracker.com/events/epicgames_" + match + "_" + \
                week + "_" + region + "?window=" + match + "_" + week + "_" + region + \
                "_" + event + "&page=" + str(page)

            # Import Trios
            # https://fortnitetracker.com/events/epicgames_CashCup_Trios1_NAE?window=CashCup_Trios1_NAE_Event2&page=2
            # url = "https://fortnitetracker.com/events/epicgames_" + match + "_" + \
            #    region + "?window=" + match + "_" + region + \
            #    "_" + event + "&page=" + str(page)
            # print(url)

            # Import World Cup
            response = requests.get(url)
            f = open("c:\\fortnite-scrape\\scraped\\worldcup\\" + region + "_" + week +
                     "_" + str(page) + ".html", "w+", encoding="utf-8")
            f.write(response.text)
            f.close()

        time.sleep(3)
print("Done")
