#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

QUERY_IP='{{ range .NetworkSettings.Networks }}{{ .IPAddress }}{{ end }}'
QUERY_PORT='{{ range $key, $value := .NetworkSettings.Ports }}{{ $key }}{{ end }}'
QUERY_HOST='{{ .Config.Hostname }}'
QUERY_DOMAIN='{{ .Config.Domainname }}'

function container_details() {

  local IPADDR=`docker inspect -f "$QUERY_IP" $1`
  local PORT=`docker inspect -f "$QUERY_PORT" $1`
  local PORT=`echo $PORT | awk -F'/' '{ print $1 }'`

  local HOST=`docker inspect -f "$QUERY_HOST" $1`
  local DOMAIN=`docker inspect -f "$QUERY_DOMAIN" $1`

  if [ -n "$DOMAIN" ]; then
    HOST="$HOST.$DOMAIN"
  fi

  printf "%-22s is running on: %s:%s\n" $HOST $IPADDR $PORT
}

container_details 'tangoworkspace_databaseds_1'
container_details 'tangoworkspace_mtango_1'
