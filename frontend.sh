#!/bin/bash
git pull
head_name() {
    echo -e "\e[33m>>>>>>>>>> $* <<<<<<<<<<\e[0m"
}
status_check() {
    echo "exit status $?"
}



head_name install nginx
dnf install nginx -y 
status_check

head_name remove the old web contenrt
rm -rf /usr/share/nginx/html/* 
status_check

head_name Download the frontend content
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip 
status_check

head_name Extract the frontend content
unzip -o /tmp/frontend.zip -d /usr/share/nginx/html
status_check


# -o  override , -d destination

head_name copy expence conf file
cp expense.conf /etc/nginx/default.d/expense.conf
status_check

head_name enable nginx service
systemctl enable nginx
status_check

head_name restart nginx service
systemctl restart nginx
status_check
