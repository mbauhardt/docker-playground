## Installation

Install <https://www.docker.com/> onto your system.
Clone this project

    $ git clone git@github.com:mbauhardt/docker-playground.git
    $ cd docker-playground/hadoop


## Build the image

Before you can start hadoop/hive you have to build the image.  The
default hadoop version is 2.6.0, so lets give the image a name to
reflect this version 

    $ docker build -t 'hadoop-2.6.0' .


## Start a container based on that image

    $ docker run --hostname hadoopbox --name 'hadoop-2.6.0-container' 'hadoop-2.6.0'

We defined the hostname `hadoopbox`. Why? Because we have hardcoded
hadoop config files - [core-site.xml](conf/hadoop/core-site.xml) - which
refers to this name.  I recommend to put this name including the IP of
the started container into your `/etc/hosts`. To figure out how the IP
address of the hadoop container is execute

    $ docker inspect hadoop-2.6.0-container | grep IPAddress

And update the hosts file e.g.

    $ echo '172.17.0.2 hadoopbox' >> /etc/hosts


The following ports are exposed

* NameNode on port `9000`
* ResourceManager on port `8032`
* ResourceManagerSchedulerAddress on port `8030`
* ResourceManagerWebAddress on port `8090`


## Access the container

You can access the container and run some jobs

    $ docker exec -it hadoop-2.6.0-container bash
    $ /opt/hadoop/bin/hadoop jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar pi 3 10
    $ /opt/hive/bin/beeline -u jdbc:hive2://localhost:10000/default
    $ beeline> select * from pokes;
    $ beeline> select * from invites;


## Stop the container

If you do not need the container anymore

    $ docker container stop hadoop-2.6.0-container

If you want to start the container again, the command `docker start hadoop-2.6.0-containe` is not working somehow. So we have to remove this conatiner competely.

    $ docker container rm hadoop-2.6.0-container


## Can I start another hadoop/hive version

Si Senor.

    $ docker build --build-arg HADOOP_VERSION=2.9.2 --build-arg HIVE_VERSION=2.3.5 -t 'hadoop-2.9.2' .


