#!/bin/bash

#	This script calculates the next occurring hour that is divisible by 2.  It then feeds that integer
#	back into a date format to be passed to a countdown.js timer

#	Please note there are several hacks herein:
#		1. I should be able to use the date function to calculate this value directly
#		2. I really thought there was another.  hmm
#	Anyway, I'm an amateur script coder. Please feel free to suggest improvements

#	Get the hour, two hours from now.
HOUR=`date -v+2H | cut -d " " -f 4 | cut -c 1,2` 

# 	Create a date format compatible with Robert Hashemian's countdown javascript
#	http://scripts.hashemian.com/js/countdown.js
#	12/31/2020 18:00"  (We do not care about any field's accuracy except hour)
DATE="12/31/2020 $HOUR:00"

echo $DATE