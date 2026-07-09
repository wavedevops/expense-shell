head_name() {
    echo -e "\e[33m>>>>>>>>>> $* <<<<<<<<<<\e[0m"
}
status_check() {
    echo "exit status $?"
}

head_name "Setup MySQL Root Password"
export MYSQL_ROOT_PASSWORD="ExpenseApp@1"
status_check

head_name disable nodejs
dnf module disable nodejs -y
status_check

head_name enable nodejs 20 
dnf module enable nodejs:20 -y
status_check


head_name installing nodejs service
dnf install nodejs -y
status_check


head_name adding expense user

if id expense &>/dev/null; then
    echo "User expense already exists... SKIPPING"
else
    useradd expense
    echo "Creating expense user"
fi
status_check
#Every time The if condition executes based on the command's exit status.


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
mysql -h $MYSQL_ROOT_PASSWORD -uroot -pExpenseApp@1 < /app/schema/backend.sql 
status_check