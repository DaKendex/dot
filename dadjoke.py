#!/usr/bin/env python3
# source: 'https://gist.github.com/itsthejoker/33c390748fd8d4184ca81d421b69f9e6'
#from urllib.request import urlopen
#import json
#import random
#
#resp = urlopen("https://fatherhood.gov/jsonapi/node/dad_jokes")
#joke = random.choice(json.loads(resp.read()).get('data')).get('attributes')
#if joke:
#    print(joke.get('field_joke_opener'))
#    print(joke.get('field_joke_response'))
import requests
from rich import print
import random

resp = requests.get("https://fatherhood.gov/jsonapi/node/dad_jokes")
resp2 = requests.get("https://fatherhood.gov/jsonapi/node/dad_jokes?page%5Boffset%5D=50&page%5Blimit%5D=50")
resp3 = requests.get("https://fatherhood.gov/jsonapi/node/dad_jokes?page%5Boffset%5D=150&page%5Blimit%5D=50")
jokes = resp.json()['data'] + resp2.json()['data'] + resp3.json()['data']
joke = random.choice(jokes)
if joke:
    print("[green] {0}".format(joke['attributes']['field_joke_opener']))
    print("[yellow] {0}".format(joke['attributes']['field_joke_response']))
