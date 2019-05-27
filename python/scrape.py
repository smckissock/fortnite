import requests

from db import cmd, cursor, conn


def save_places (json, week, region, solo_or_duo):
    try:
        for place in json.get("entries"):

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

            # Insert first player (or only if it is solo)    
            #cursor.execute("INSERT INTO Place VALUES (?, ?, ?, ?, ?, ?, ?)", \
            #    week, solo_or_duo, name1, region, rank, payout, points)
            #conn.commit()            
            
            
            if  name1 == "Nittle GG":
                print("Posick") 

            # duo
            if solo_or_duo == 'Duo':  
                name2 = ''
                if len(display_names) > 1:
                    if display_names[1] is not None:
                        name2 = display_names[1] 

                if  name2 == "Posick GG":
                    print("Posick") 

                #cursor.execute("INSERT INTO Place VALUES (?, ?, ?, ?, ?, ?, ?)", \
                #    week, solo_or_duo, name2, region, rank, payout, points)
                #conn.commit()
    except Exception as e:
        print('Error inserting Place PLAYER1=' + name1 + ' PLAYER2=' + name2 + " " + str(e)) 
        

regions = ["NAE", "NAW", "EU", "OCE", "ASIA", "BR"]
solo_weeks = ["Week1", "Week3", "Week5"]
duo_weeks = ["Week2", "Week4", "Week6"]
event = "Event2"
for region in regions:

    print(region)
    
    for solo_week in solo_weeks:
        url = "https://www.epicgames.com/fortnite/competitive/api/leaderboard/epicgames_OnlineOpen_" + solo_week + "_" + region + "/OnlineOpen_" + solo_week + "_" + region + "_" + event
        response = requests.get(url)
        json = response.json()
        save_places(json, solo_week, region, "Solo")   

    for duo_week in duo_weeks:
        url = "https://www.epicgames.com/fortnite/competitive/api/leaderboard/epicgames_OnlineOpen_" + duo_week + "_" + region + "/OnlineOpen_" + duo_week + "_" + region + "_" + event
        response = requests.get(url)
        json = response.json()
        save_places(json, duo_week, region, "Duo")

print("Done")        
        

#"https://www.epicgames.com/fortnite/competitive/api/leaderboard/epicgames_OnlineOpen_Week1_NAE/OnlineOpen_Week1_NAE_Event2"

#"https://www.epicgames.com/fortnite/competitive/api/leaderboard/epicgames_OnlineOpen_Week6_NAE/OnlineOpen_Week6_NAE_Event2"

#response = requests.get("https://www.epicgames.com/fortnite/competitive/api/leaderboard/epicgames_OnlineOpen_Week6_NAE/OnlineOpen_Week6_NAE_Event2")

#print(response.text)