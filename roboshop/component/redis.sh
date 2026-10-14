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
sudo dnf upgrade -y
stat $?

echo -n "Start Installing Epel : "
sudo dnf install -y spal-release   &>>LOGPATH
stat $? 


echo -n "Start Configuring $COMPONENT dir : "
sudo dnf repolist
stat $? 

echo -n "Start enabling  $COMPONENT : "
sudo dnf install -y yum-utils
stat $? 

echo -n "Start Installing $COMPONENT : "
dnf install redis6 -y 
stat $? 