#!/bin/bash

docker_image="bag2image-parser"

docker_status=`dpkg -l | grep docker.io | awk '{print $1}'`
if [ -z $docker_status ]
then
    echo CASE1
    need_install_docker=1
elif [ $docker_status != "ii" ]
then
    echo CASE2
    need_install_docker=1
else
    echo
    need_install_docker=0
fi

if [ need_install_docker == 1 ]
then
    sudo apt install docker.io
fi

found_image=`docker image ls | grep $docker_image`
if [ -z $docker ]
then
    wget https://github.com/standmit/bag2image/raw/master/parser.dockerfile
    docker build -t $docker_image -f parser.dockerfile .
    rm parser.dockerfile
fi

docker run --mount type=bind,source=$PWD,target=/tmp/share $docker_image
