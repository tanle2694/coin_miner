import requests
import time
print(requests.get("https://ipinfo.io").json())
time.sleep(1)