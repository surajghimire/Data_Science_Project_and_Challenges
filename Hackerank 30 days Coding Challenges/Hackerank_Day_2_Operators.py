# -*- coding: utf-8 -*-
"""
Created on Fri Dec 17 13:40:32 2021

@author: sghmr
"""

#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'solve' function below.
#
# The function accepts following parameters:
#  1. DOUBLE meal_cost
#  2. INTEGER tip_percent
#  3. INTEGER tax_percent
#

def solve(meal_cost, tip_percent, tax_percent):
    # Write your code here
    meal_price= round(meal_cost*(100.0+ tip_percent+ tax_percent)/100)
    print(meal_price)
    return None

if __name__ == '__main__':
    meal_cost = float(input().strip())

    tip_percent = int(input().strip())

    tax_percent = int(input().strip())

    solve(meal_cost, tip_percent, tax_percent)
