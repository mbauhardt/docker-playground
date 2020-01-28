# Installation

Install <https://www.docker.com/> onto your system.
Clone this project

    $ git clone git@github.com:mbauhardt/docker-playground.git
    $ cd docker-playground/hadoop


# Build the image

Before you can start hadoop/hive you have to build the image.

    # The default hadoop version is 2.6.0, so lets give the image a name to reflect this version 
    $ docker build -t 'hadoop-2.6.0' .
    

