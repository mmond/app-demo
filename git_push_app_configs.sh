#!/bin/bash

echo "App/Dir name:"
read APP


git add $APP/nginx.conf $APP/config/ $APP/script/spin ; git commit -a -m "app configs" ; git push
