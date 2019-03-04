#!/usr/bin/env python3
"""
Stock Price
"""

import sys
import requests

icon   = sys.argv[1]
ticker = sys.argv[2]
price  = requests.get('https://api.iextrading.com/1.0/stock/' + ticker + '/price').text

print("{0} ${1:,.2f}".format(icon, float(price)))
