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
    if [ $1 -ne 0 ] ; then
        echo -e "\e[32m Success \e[0m "
    else
        echo -e "\e[31m Failure \e[0m "
    fi
}


echo -n " Start Installing Node JS for $COMPONENT : "
yum install nodejs make gcc-c++ -y   &>>LOGPATH
stat $?


echo -n "User Creation for configure $COMPONENT : "
id roboshop -u
if [ $? -ne 0 ] ; then
    useradd roboshop
    stat $?
else
    echo -e "\e[33m Skipping \e[0m"

fi

echo -n " Downloading File for $COMPONENT : "
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"  &>>LOGPATH
stat $?

echo -n "extracting $COMPONENT : "
cd /home/roboshop
unzip /tmp/catalogue.zip &>>LOGPATH
stat $?

echo -n "Configure permission : "
mv /home/roboshop/catalogue-main /home/roboshop/catalogue
chown -r roboshop:roboshop /home/roboshop/catalogue/   
stat $?

echo -n "Installing NPM : "
cd /home/roboshop/catalogue
npm install  &>>LOGPATH
stat $?







