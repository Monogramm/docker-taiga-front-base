#!/bin/sh

# Automatically replace "TAIGA_HOSTNAME" with the environment variable
sed -i "s/TAIGA_HOSTNAME/$TAIGA_HOSTNAME/g" /taiga/conf.json

# Look to see if we should set the "eventsUrl"
if [ -n "$RABBIT_PORT_5672_TCP_ADDR" ]; then
  echo "Enabling Taiga Events"
  sed -i "s/eventsUrl\": null/eventsUrl\": \"ws:\/\/$TAIGA_HOSTNAME\/events\"/g" /taiga/conf.json
  mv /etc/nginx/taiga-events.conf /etc/nginx/conf.d/default.conf
fi

# Handle enabling/disabling SSL
if [ "$TAIGA_SSL_BY_REVERSE_PROXY" = "True" ]; then
  echo "Enabling external SSL support! SSL handling must be done by a reverse proxy or a similar system"
  sed -i "s/http:\/\//https:\/\//g" /taiga/conf.json
  sed -i "s/ws:\/\//wss:\/\//g" /taiga/conf.json
elif [ "$TAIGA_SSL" = "True" ]; then
  echo "Enabling SSL support!"
  sed -i "s/http:\/\//https:\/\//g" /taiga/conf.json
  sed -i "s/ws:\/\//wss:\/\//g" /taiga/conf.json
  mv /etc/nginx/ssl.conf /etc/nginx/conf.d/default.conf
elif grep -q "wss://" "/taiga/conf.json"; then
  echo "Disabling SSL support!"
  sed -i "s/https:\/\//http:\/\//g" /taiga/conf.json
  sed -i "s/wss:\/\//ws:\/\//g" /taiga/conf.json
fi

# Look to see if we should update the backend connection
if [ -n "$TAIGA_BACK_HOST" ]; then
  echo "Updating Taiga Back connection"
  sed -i \
    -e "s|proxy_pass http://.*/api|proxy_pass http://$TAIGA_BACK_HOST:$TAIGA_BACK_PORT/api|g" \
    -e "s|proxy_pass http://.*\$request_uri|proxy_pass http://$TAIGA_BACK_HOST:$TAIGA_BACK_PORT\$request_uri|g" \
    /etc/nginx/conf.d/default.conf
fi

# Look to see if we should update the events connection
if [ -n "$TAIGA_EVENTS_HOST" ]; then
  echo "Updating Taiga Events connection"
  sed -i \
    -e "s|proxy_pass http://.*/events|proxy_pass http://$TAIGA_EVENTS_HOST:$TAIGA_EVENTS_PORT/events|g" \
    /etc/nginx/conf.d/default.conf
fi

# Start nginx server
nginx -g "daemon off;"