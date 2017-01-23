# tango-workspace

This project allows one to deploy
[TANGO Controls](http://www.tango-controls.org/) in a distributed setup
using Docker containers.

Following hosts are configured:

* mysql
  * MySQL 5.7 database
* databaseds
  * DataBaseds
  * Starter
  * TangoAccessControl
* tangotest
  * Starter
  * TangoTest
* mtango
  * Starter
  * TangoRestServer

## Getting started

Make sure you have required software:

* [Docker 1.10 (or better)](https://docs.docker.com/engine/installation/)
* [Docker Compose 1.7 (or better)](https://docs.docker.com/compose/install/)

Clone the repository and type and start docker-compose:

```
$ git clone https://github.com/mliszcz/tango-workspace.git
$ cd tango-workspace; docker-compose up
```

Check addresses of your containers:

```
$ ./status.sh
databaseds.workspace   is running on: 172.18.0.3:10000
mtango.workspace       is running on: 172.18.0.5:8080
```

Shutdown the cluster when you are done:

```
$ docker-compose down
```

### Persistent database

If you want the database persistent, just uncomment the following line in
`docker-compose.yml`:

```yaml
- ./.data/mysql:/var/lib/mysql
```
