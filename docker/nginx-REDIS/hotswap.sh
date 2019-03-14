#! /bin/bash
PARAM="$1"

line=$(awk '/6379;/{print}' /etc/nginx/nginx.conf)

server_name=$(echo $line | cut -d ':' -f 1)

if [ "server $PARAM" == "$server_name" ]; then
    echo "The file is already pointing to it."
else
    sed -i "11s/.*/    server $PARAM:6379;/" /etc/nginx/nginx.conf
    sed -i "15s/.*/    listen 8888 so_keepalive=on;/" /etc/nginx/nginx.conf
fi

/usr/sbin/nginx -s reload
