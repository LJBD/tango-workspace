#!/bin/bash

docker run -it --rm --name tango_databaseds \
  -e TANGO_HOST=127.0.0.1:10000 \
  -e MYSQL_HOST=mysql_db -e MYSQL_USER=tango -e MYSQL_PASSWORD=tango -e MYSQL_DATABASE=tango_db \
  --link mysql_db:mysql_db \
  mliszcz/tango-cs:latest
