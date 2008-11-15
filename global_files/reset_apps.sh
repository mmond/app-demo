#!/bin/bash

#	Reset the applications
#	Spree
cd /var/www/spree/current
rake production db:bootstrap AUTO_ACCEPT=Y		
#	El Dorado
cd /var/www/eldorado/current
export RAILS_ENV='production'
rake db:schema:load ; rake db:migrate
#	TuneUp with El Dorado
cd /var/www/eldorado_tuneup/current
export RAILS_ENV='production'
rake db:schema:load ; rake db:migrate
#	Mephisto
cd /var/www/mephisto/current
rake db:bootstrap
#	Jobber 


#	This section calculates the next occurring hour that is divisible by 2.  It then 
#	converts that integer back into a date format and inserts it back into index.html

#	Please note there are several hacks herein:
#		1. I should be able to use the date function to calculate this value directly
#		2. I really thought there was another.  hmm
#	Anyway, please feel free to suggest improvements

#	Reset the variable in the html doc
cp -f /var/www/global_files/index.fresh /var/www/main/index.html

#	Get the hour, two hours from now.   (originally:
#	HOUR=`date -v+2H | cut -d " " -f 4 | cut -c 1,2` but Linux does not support -v
HOUR=`date | cut -d " " -f 4 | cut -c 1,2` ; HOUR=$(($HOUR+2))

# 	Create a date format compatible with Robert Hashemian's countdown javascript
#	http://scripts.hashemian.com/js/countdown.js
#	12/31/2020 18:00"  (We do not care about any field's accuracy except hour)
DATE="Nov 10 2080 $HOUR:00 UTC"

# 	Update the COUNTDOWNSETTIME variable in the html doc
cat /var/www/main/index.html | sed "s/COUNTDOWNSETTIME/$DATE/" > /var/www/main/index.tmp
mv /var/www/main/index.tmp /var/www/main/index.html

#	Log the activity
date > /var/www/main/reset.txt
