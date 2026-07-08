#!/usr/bin/env python3
import sys
import requests
import os

def send_slack_message(message):
    token = os.getenv("SLACK_TOKEN")

    assert token is not None

    resp = requests.post("https://slack.com/api/chat.postMessage", data={
        "channel": "U8ZRKTSLE",
        "text": message
    }, headers={
        "Authorization": f"Bearer {token}"
    })


if __name__ == "__main__":
    send_slack_message(sys.argv[1])

