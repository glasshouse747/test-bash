component_name=shipping
source common.sh

java

dnf install mysql -y
mysql -h mysql-dev.mydevops.shop -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h mysql-dev.mydevops.shop -uroot -pRoboShop@1 < /app/db/app-user.sql
mysql -h mysql-dev.mydevops.shop -uroot -pRoboShop@1 < /app/db/master-data.sql

systemd_setup