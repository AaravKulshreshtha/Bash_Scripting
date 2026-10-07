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
yum install nginx -y   &>> $LogPath
stat $?

echo -n "Enabling $Component : "
 systemctl enable nginx   &>> $LogPath
stat $?

echo -n "Starting $Component :"
systemctl start nginx   &>> $LogPath
stat $?

 echo -n "Creating $Component Directory : "
 curl "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >> /tmp/frontend.zip   &>> $LogPath
 stat $?

echo -n "Opening the $Component Hosting Path : "
cd /usr/share/nginx/html
stat $?


echo -n "Clenup the $Component Hosting Path : "
rm -rf * 
stat $?


echo -n "unzip Hosting File : "
unzip /tmp/frontend.zip
stat $?


echo -n "Moving the $Component hosting file : "
mv frontend-main/* .
stat $?

echo -n "Moving the $Component static file : "
mv static/* .
stat $?

echo -n "deleting the $Component README.md file : "
rm -rf frontend-master README.md
stat $?


echo -n "raplacing the $Component config file : "
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?


echo -n "restarting the $Component  : "
systemctl restart nginx 
stat $?
