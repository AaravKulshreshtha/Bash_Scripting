!#bin/bash

echo "---------------------------------Redis Configuration Start--------------------------------------"

# Checking weather user is Root or not ?

ID=id -u
if [ $ID -ne 0 ] ; then
    echo " This script supposed to be run as administartor. "
fi

COMPONENT=$1
LOGPATH=/etc/$1.log

stat() {
    if [ $1 -eq 0 ] ; then
        echo "\e[32m Success \e[0m "
    else
        echo "\e[31m Failure \e[0m "
}


echo -n "Start Installing $COMPONENT : "
yum install epel-release yum-utils -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum-config-manager --enable remi
yum install redis -y
stat $? 