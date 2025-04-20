component_name=catalogue
source common.sh

nodejs

cp ${pwd}/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.mydevops.shop </app/db/master-data.js

systemd_setup