#!bin/bash

echo "--------------------------------- Catalogue Configuration Start ---------------------------------"

# Checking weather script run with root user ?

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo " This script supposed to be run as administartor"
fi

COMPONENT=$1
LOGPATH=/tmp/$1.log

stat () {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m "
    else
        echo -r "\e[31m Failure \e[0m "
    fi
}


echo -n " Start Installing Node JS for $COMPONENT : "
yum install nodejs make gcc-c++ -y   &>>LOGPATH
stat $?


echo -n "User Creation for configure $COMPONENT : "
useradd roboshop
stat $?


