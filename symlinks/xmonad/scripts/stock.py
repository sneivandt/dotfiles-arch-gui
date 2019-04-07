#!/usr/bin/env python3
"""
Market Summary
"""

import urllib.request, json
import sys

icon   = sys.argv[1]
ticker = sys.argv[2]

with urllib.request.urlopen('https://api.iextrading.com/1.0/stock/' + ticker + '/quote?displayPercent=true') as url:
    d = json.loads(url.read().decode())
    print('{0} ${1:,.2f} {2:+,.2f} ({3:+,.2f}%)'.format(icon, d['latestPrice'], d['change'], d['changePercent']))
