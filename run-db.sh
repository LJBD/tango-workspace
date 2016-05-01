#!/bin/bash

mkdir -p .data/mysql

docker run -it --name mysql_db --rm \
  -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=tango_db -e MYSQL_USER=tango -e MYSQL_PASSWORD=tango \
  -v $PWD/database/install_scripts:/docker-entrypoint-initdb.d:ro \
  -v $PWD/.data/mysq:/var/lib/mysql \
  mysql:5.7 \
  --sql-mode=""
