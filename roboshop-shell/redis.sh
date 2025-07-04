component_name=redis
source common.sh

dnf module disable redis -y
dnf module enable redis:7 -y
dnf install redis -y
sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode yes/c protected-mode no' /etc/redis/redis.conf

systemctl restart redis
systemctl daemon-reload
systemctl enable redis
systemctl start redis

