#!/bin/bash

echo "---------------------------------Redis Configuration Start--------------------------------------"

# Checking weather user is Root or not ?

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo " This script supposed to be run as administartor. "
fi

COMPONENT=$1
LOGPATH=/etc/$1.log

stat() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m "
    else
        echo -e "\e[31m Failure \e[0m "
    fi
}

echo -n "Start Upgrading OS : "
sudo dnf upgrade -y &>>LOGPATH
stat $?

echo -n "Start Installing Epel : "
sudo dnf install -y spal-release   &>>LOGPATH
stat $? 


echo -n "Start Configuring $COMPONENT dir : "
sudo dnf repolist  &>>LOGPATH
stat $? 

echo -n "Start enabling  $COMPONENT : "
sudo dnf install -y yum-utils  &>>LOGPATH
stat $? 

echo -n "Start Installing $COMPONENT : "
dnf install redis6 -y &>>LOGPATH
stat $? 

echo -n "Changing IP address of $COMPONENT : "
sed -i -e '/bind/s/127.0.0.0/0.0.0.0/' /etc/redis6/redis6.conf
stat $? 


echo -n "Start enabling  $COMPONENT : "
systemctl enable redis6 &>>LOGPATH
stat $? 

echo -n "Start enabling  $COMPONENT : "
systemctl start redis6 &>>LOGPATH
stat $? 