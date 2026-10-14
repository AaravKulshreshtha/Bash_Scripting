#!/bin/bash

echo "----------------------------------User Configuration Start-------------------------------------------"

# Checking weather script running with Root or Not?

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo "This script supposed to be run as root user "
fi

COMPONENT=$1
LOGPATH=/tmp/$1.log

#Function for cheking weather command excuted properly or not 

stat() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m "
    else
        echo -e "\e[31m Failure \e[0m"
    fi
}

echo -n "Start Installing Node Js : "
yum install nodejs make gcc-c++ -y &>>LOGPATH
stat $? 


echo -n "Creating Application user : "
id roboshop -u  &>>LOGPATH
if [ $? -ne 0 ] ; then
    useradd roboshop
    stat $?
else
    echo -e "\e[33m Skipping \e[0m "
fi

echo -n " Downloading user files : "
curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip"   &>>LOGPATH
stat $?

echo -n "Unzip Files : "
cd /home/roboshop
unzip /tmp/user.zip  &>>LOGPATH
stat $?

echo -n " Configure permissions of $COMPONENT  : "
mv /home/roboshop/user-main /home/roboshop/user &>>LOGPATH
chown -R roboshop:roboshop /home/roboshop/user/ &>>LOGPATH
stat $?

echo -n " Installing NPM : "
cd /home/roboshop/user  
npm install  &>>LOGPATH
stat $?

echo -n "Creating $COMPONENT service : "
mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service  &>>LOGPATH
stat $?

echo -n  "reloading  $COMPONENT Dameon : "
systemctl daemon-reload  &>>LOGPATH
stat $?

echo -n  "Enbaling  $COMPONENT Service : "
systemctl enable user  &>>LOGPATH
stat $?

echo -n  "Starting $COMPONENT Service : "
systemctl start user  &>>LOGPATH
stat $?

echo -n " Updating Redis ip : "
sed -i -e "s/REDIS_ENDPOINT/172.31.17.197/" /etc/systemd/system/user.service
stat $?


echo -n " Updating mongoDB ip : "
sed -i -e "s/MONGO_ENDPOINT/172.31.23.14/" /etc/systemd/system/user.service
stat $?

echo -n  "RE-Starting $COMPONENT Service : "
systemctl restart user  &>>LOGPATH
stat $?

echo "----------------------------------User Configuration FINISH-------------------------------------------"