import time

import notifications
import requests

SERVICE_URLS = [
    "https://methylsight.cu-bic.ca",
    "https://ptarpmir.cu-bic.ca",
    "https://stardb.cu-bic.ca",
    "https://cu-bic.ca",
]

for service_url in SERVICE_URLS:
    response = requests.get(service_url)
    status_code = response.status_code

    if status_code != 200:
        notifications.send_slack_message(f"Service hosted at `{service_url}` returned a non-200 status code!")

    time.sleep(1)
