#!/bin/bash
#echo " Checking weather user is Root or not"

ID=$(id -u)

if [ $ID -ne 0 ] ; then
    echo " its script supposed to be run as root user"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e  "\e[31m failure \e[0m"
    fi

}

Component="Nginx"
LogPath="/tmp/$1.log"

echo -n  " Start Installating $Component :"
yum install nginx -y   &>> /tmp/frontend.log
stat $?

echo -n "Enabling $Component : "
 systemctl enable nginx   &>> /tmp/frontend.log
stat $?

echo -n "Starting $Component :"
systemctl start nginx   &>> /tmp/frontend.log
stat $?

 echo -n "Creating $Component Directory : "
 curl "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >> /tmp/frontend.zip
 stat $?
