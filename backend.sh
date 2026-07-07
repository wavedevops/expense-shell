head_name() {
    echo -e "\e[33m>>>>>>>>>> $* <<<<<<<<<<\e[0m"
}
status_check() {
    echo "exit status $?"
}

head_name disable nodejs
dnf module disable nodejs -y
status_check

head_name enable nodejs 20 
dnf module enable nodejs:20 -y
status_check


head_name
dnf install nodejs -y
status_check


head_name adding expense user
useradd expense
status_check


head_name We keep application files in one standard location
mkdir /app 
status_check


head_name download backend content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip 
status_check


head_name  unzip the backend content
unzip -o /tmp/backend.zip -d /app
status_check


head_name Install Node.js Dependencies
npm --prefix /app install
status_check


head_name copying backend conf file 
cp backend.service /etc/systemd/system/backend.service
status_check

head_name daemon-reload
systemctl daemon-reload
status_check

head_name enable and staet backend service 
systemctl enable backend 
systemctl start backend
status_check

head_name install mysql clint 
dnf install mysql -y 
status_check

head_name
mysql -h 172-31-40-76 -uroot -pExpenseApp@1 < /app/schema/backend.sql 
status_check