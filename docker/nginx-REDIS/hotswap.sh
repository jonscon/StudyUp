#! /bin/bash
PARAM="$1"

if [ $PARAM ==  "redis" ]; then
    sed -i "11s/.*/    server %{REDIS_HOST}:%{REDIS_PORT};/" /etc/nginx/nginx.conf
    sed -i "15s/.*/    listen %{PROXY_PORT} so_keepalive=on;/" /etc/nginx/nginx.conf
    echo "original!"
else
    sed -i "11s/.*/    server $PARAM:6379;/" /etc/nginx/nginx.conf
    sed -i "15s/.*/    listen 8888 so_keepalive=on;/" /etc/nginx/nginx.conf
    echo $PARAM
fi

/usr/sbin/nginx -s reload
