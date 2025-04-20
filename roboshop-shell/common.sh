pwd=$(pwd)

app_pre_setup() {
  cp ${pwd}/${component_name}.service /etc/systemd/system/${component_name}.service
  id roboshop || useradd roboshop
  rm -rf /app
  mkdir /app
  curl -L -o /tmp/${component_name}.zip https://roboshop-artifacts.s3.amazonaws.com/${component_name}.zip
  cd /app
  unzip /tmp/${component_name}.zip
}

golang() {
  dnf install golang -y
  app_pre_setup
  go mod init ${component_name}
  go get
  go build
}

java() {
  dnf install maven -y
  app_pre_setup
  mvn clean package
  mv target/${component_name}-1.0.jar ${component_name}.jar
}

nodejs() {
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  dnf install nodejs -y
  app_pre_setup
  npm install
}

python() {
  dnf install python3 gcc python3-devel -y
  app_pre_setup
  pip3 install -r requirements.txt
}

systemd_setup() {
  systemctl restart ${component_name}
  systemctl daemon-reload
  systemctl enable ${component_name}
  systemctl start ${component_name}
}

