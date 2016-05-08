
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HOSTALIASES=$DIR/.config/hosts

QUERY_IP='{{ range .NetworkSettings.Networks }}{{ .IPAddress }}{{ end }}'
QUERY_PORT='{{ range $key, $value := .NetworkSettings.Ports }}{{ $key }}{{ end }}'
QUERY_HOST='{{ .Config.Hostname }}'
QUERY_DOMAIN='{{ .Config.Domainname }}'

CONTAINER=tangocsworkspace_databaseds_1

IPADDR=`docker inspect -f "$QUERY_IP" $CONTAINER`
TCPPORT=`docker inspect -f "$QUERY_PORT" $CONTAINER`
HOST=`docker inspect -f "$QUERY_HOST" $CONTAINER`
DOMAIN=`docker inspect -f "$QUERY_DOMAIN" $CONTAINER`

PORT=`echo $TCPPORT | awk -F'/' '{ print $1 }'`

if [ -n "$DOMAIN" ]; then
  HOST="$HOST.$DOMAIN"
fi

printf "$HOST $IPADDR \n" > $HOSTALIASES

export HOSTALIASES
export TANGO_HOST="$HOST:$PORT"

SEDPROGRAM="s/.*\(${HOST//./\\.}\).*/$IPADDR \1/g"

H=$HOST
IP=$IPADDR
SEDPROG="/.*${H//./\\.}.*/{h;s/^.*$/$IP $H/};\${x;/^$/{s//$IP $H/;H};x}"

echo "DataBaseds is running on: $IPADDR:$PORT"
echo "Exported: TANGO_HOST=$TANGO_HOST"
echo "Exported: HOSTALIASES=$HOSTALIASES"
echo "You may also need to adjust your DNS settings or run:"
echo "sudo sed -i '$SEDPROG' /etc/hosts"
