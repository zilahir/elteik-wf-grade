#!/usr/bin/python

import requests
validaror_url = "https://validator.w3.org/nu/"
ip_address = "http://webfejlesztes.inf.elte.hu/201620171/honlapok/bi7tw8/index.html"
params = { "doc": ip_address, "out": "json"}

response = requests.get(validaror_url,
                        params=params)

print(response.json())
