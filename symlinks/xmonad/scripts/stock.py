#!/usr/bin/env python3
"""
Stock Price
"""

import sys
import requests

ticker = sys.argv[1]
R = requests.get('https://api.iextrading.com/1.0/stock/' + ticker + '/price')
price = R.text


print("{0} ${1:,.2f}".format(ticker.upper(), float(price)))
