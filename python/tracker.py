import requests

from db import cmd, cursor, conn, max_id

def save_response(json):
    
    cursor.execute("INSERT INTO Tracker (json) VALUES (" + json + ")")
    conn.commit()

#key_name = 'TRN-Api-Key'
#key_name = 'api-key'
#key = 'aZgEJoVflQbuD4n0_ZZIFQ2'
#key = '869bac1a-f964-44bb-9bf2-e4ab8a26aa08'

#headers = {key_name: key}


headers = {
    'TRN-Api-Key' : '869bac1a-f964-44bb-9bf2-e4ab8a26aa08'
}

url = "https://api.fortnitetracker.com/v1/profile/pc/posick"


#response = requests(url, headers=headers)


response = requests.get(url, headers=headers)
json = response.json()
save_response(json)

print("Done")


#save_places(json, solo_week, region, "Solo")   