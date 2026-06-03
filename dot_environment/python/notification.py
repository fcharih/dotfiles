#! /usr/bin/env python3
import os, sys
import http.client, urllib

def notify(message):
    conn = http.client.HTTPSConnection("api.pushover.net:443")
    conn.request("POST", "/1/messages.json",
    urllib.parse.urlencode({
        "token": os.getenv("PUSHOVER_TOKEN"),
        "user": os.getenv("PUSHOVER_USER"),
        "message": message,
    }), { "Content-type": "application/x-www-form-urlencoded" })
    conn.getresponse()

if __name__ == '__main__':
	notify(sys.argv[1])
