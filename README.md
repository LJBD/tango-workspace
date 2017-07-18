# tango-workspace

This project allows one to deploy
[TANGO Controls](http://www.tango-controls.org/) in a distributed setup
using Docker containers.

Following hosts are configured:

* mariad_db
  * Maria database
* databaseds
  * DataBaseds
  * Starter
  * TangoAccessControl
* tangotest
  * Starter
  * TangoTest
* taurus
  * Starter
  * Taurus

## Getting started

Make sure you have required software:

* [Docker 1.10 (or better)](https://docs.docker.com/engine/installation/)
* [Docker Compose 1.7 (or better)](https://docs.docker.com/compose/install/)

Clone the repository and type and start docker-compose:

```
$ git clone https://github.com/synchrotron-solaris/tango-workspace.git
$ cd tango-workspace; docker-compose up
```

Check addresses of your containers:

```
$ ./status.sh
databaseds.workspace   is running on: 172.18.0.3:10000
mtango.workspace       is running on: 172.18.0.5:8080
```

Remember, `in docker-compose.yml`, taurus section, you have to set DISPLAY 
to `your_ip_addres:0`

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
 ### Problems with maria_db or databaseds
 If you encounter problems with starting one of those containers, change in 
 `docker-compose.yml` those relative directories
 ```
./.config/initdb:/docker-entrypoint-initdb.d:ro
./.config/supervisord:/etc/supervisor/init.d:ro
```
to absolute ones, i.e.
 ```
C:/Users/docker_repo/tango-workspace/.config/initdb:/docker-entrypoint-initdb.d:ro
C:/Users/docker_repo/tango-workspace/.config/supervisord:/etc/supervisor/init.d:ro
```
