#!/bin/python3

import math, sys

def countBits(number):
	return int((math.log(number) / math.log(2)) + 1)

if __name__ == "__main__":
	num = num(sys.argv[1])
	print(countBits(num))
