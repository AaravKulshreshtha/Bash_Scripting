#!/bin/bash

echo "--------------------------------- Mongo DB Configuration Start ------------------------------------"

# Checking weather run with Sudo or Not 

ID=$(id -u)
if [ID -ne 0] ; then
    echo "This script supposed to be run as root user"
    exit 1
fi

COMPONENT=$1
LOGPATH="/tmp/$1.log"

stat(){
    if [$1 -eq 0] ; then
       echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[33 Failure \e[0m"
    fi
}


echo " Setup $COMPONENT repo "

echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' > /etc/yum.repos.d/mongodb.repo

stat $?

echo -n " Start Installating $COMPONENT : "

 yum install -y mongodb-org  &>> LOGPATH

 stat $?

 echo -n "Enbaling $COMPONENT : "
 
 systemctl enable mongod &>> LOGPATH

 stat $?

 echo -n "Starting $COMPONENT : "
 
 systemctl start mongod &>> LOGPATH

 stat $?


