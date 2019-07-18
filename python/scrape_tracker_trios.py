import requests

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
match = "CashCup_Trios1"
event = "Event2"

for region in regions:
    print(region)
    for week in range(1, 20):
        print(week)
        #url = "https://www.epicgames.com/fortnite/competitive/api/leaderboard/epicgames_OnlineOpen_" + solo_week + "_" + region + "/OnlineOpen_" + solo_week + "_" + region + "_" + event
        #response = requests.get(url)
        #json = response.json()
        #save_places(json, solo_week, region, "Solo")

print("Done")
