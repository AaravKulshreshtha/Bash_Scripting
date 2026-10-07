#!/bin/bash
echo " Checking weather user is Root or not"

ID=$(id -u)

if [$ID -ne 0] ; then
echo " its script supposed to be run as root user"
exit 1
fi

stat(){
if [$? -eq 0] ; then
 echo -e "\e[33m Success \e[0m"
else
 echo -e  "\e[31m failure \e[0m"
fi

}

Component="Nginx"
LogPath="/tmp/$1.log"

echo -n  " Start Installating $Component"
yum install nginx -y   &>> $LogPath
stat $?

echo -n "Enabling $Component"
 systemctl enable nginx  &>> $LogPath
stat $?

echo -n "Starting $Component"
 systemctl start nginx  &>> $LogPath
 stat $?