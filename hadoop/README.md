# Installation

Install <https://www.docker.com/> onto your system.
Clone this project

    $ git clone git@github.com:mbauhardt/docker-playground.git
    $ cd docker-playground/hadoop


# Build the image

Before you can start hadoop/hive you have to build the image.
The default hadoop version is 2.6.0, so lets give the image a name to reflect this version 

    $ docker build -t 'hadoop-2.6.0' .


# Start a container based on that image

    $ docker run --hostname hadoopbox --name 'hadoop-2.6.0-container' 'hadoop-2.6.0'

We defined the hostname `hadoopbox`. Why? Because we have hardcoded hadoop config files - (conf/hadoop/core-site.xml) - which refers to this name.


