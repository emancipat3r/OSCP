#!/bin/python3

import requests
import sys

if len(sys.argv) <= 1:
    print("USAGE: python3 custom_web_req.py http://<IP>")
else:
    headers = {

    }

    req = requests.get(sys.argv[1], headers=headers)
    print(str(req.status_code)+"\n")
    print(req.text)
