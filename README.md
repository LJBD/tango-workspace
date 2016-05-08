# tango-workspace

Up-and-running with [TANGO Controls](http://www.tango-controls.org/) in
seconds.

## What is this

A set of Docker containers that allows one to create a full-blown TANGO
infrastructure with one command.

It is based on TANGO 9.2.2.

Following hosts are started:

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
  * TangoRestServer rc2-0.3

## Getting started

### Prerequisites

Make sure you have required software:

* [Docker 1.10 (or better)](https://docs.docker.com/engine/installation/)
* [Docker Compose 1.7 (or better)](https://docs.docker.com/compose/install/)
* [Bash (optional)](https://www.gnu.org/software/bash/)
* [curl (optional)](https://curl.haxx.se/)
* [JRE (optional)](http://openjdk.java.net/)

### Installation

Just clone the repository:

```
$ git clone https://github.com/mliszcz/tango-workspace.git
```

If you want tools like Astor or Jive, run (Bash and curl required):

```
$ cd tango-workspace/
$ ./.bootstrap
```

### Usage

Start by exploring `docker-compose.yml` file. You may configure it to suit
your needs - e.g. add or remove device servers.

To run the containers, type:

```
$ docker-compose up
```

Alternatively you may use `./up` script.

You should see a bunch of logs saying the devices are started.

You may use standard `docker inspect` command to get IP's and set your
TANGO_HOST manually, or source the `tango_host.sh` file:

```
$ source tango_host.sh
DataBaseds is running on: 172.18.0.3:10000
Exported: TANGO_HOST=databaseds.workspace:10000
Exported: HOSTALIASES=/home/michal4/Documents/tango/tango-workspace/.config/hosts
You may also need to adjust your DNS settings or run:
sudo sed -i '/.*databaseds\.workspace.*/{h;s/^.*$/172.18.0.3 databaseds.workspace/};${x;/^$/{s//172.18.0.3 databaseds.workspace/;H};x}' /etc/hosts
```

Update domain name resolution and run Jive:

```
$ ./tools/jive &
```

To shutdown the containers and remove them, type:

```
$ docker-compose down
```

Or user `./down` script.

### Persistent database

You may want the database to be persistent. Just uncomment following line in
`docker-compose.yml`:

```yaml
- ./.data/mysql:/var/lib/mysql
```
