#!/bin/bash

echo "--------------------------------- Mongo DB Configuration Start ------------------------------------"

# Checking weather run with Sudo or Not 

ID=$(id -u)

if [ $ID -ne 0 ] ; then
    echo "This script supposed to be run as root user"
    exit 1
fi

COMPONENT="MongoDB"
LOGPATH="/tmp/$1.log"

stat(){
    if [ $1 -eq 0 ] ; then
       echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[31m Failure \e[0m"
    fi
}


echo -n " Setup $COMPONENT repo :  "

#sudo tee /etc/yum.repos.d/mongodb.repo > /dev/null <<'EOF'
echo '[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2023/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-7.0.asc' > /etc/yum.repos.d/mongodb.repo


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


echo -n "Update $COMPONENT IP : "

sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

stat $?

echo -n "RE-Starting $COMPONENT : "
 
 systemctl restart mongod &>> LOGPATH

 stat $?