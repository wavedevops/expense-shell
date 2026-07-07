head_name() {
    echo -e "\e[33m>>>>>>>>>> $* <<<<<<<<<<\e[0m"
}
status_check() {
    echo "exit status $?"
}

head_name "Setup MySQL Root Password"
export MYSQL_ROOT_PASSWORD="ExpenseApp@1"
status_check

head_name install Mysql
dnf install mysql-server -y
status_check

head_name enable and start Mysql service
systemctl enable mysqld
systemctl start mysqld  
status_check

head_name setup mysql root password 
mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD
status_check


# mysqld → Database server
# mysql → Client 
