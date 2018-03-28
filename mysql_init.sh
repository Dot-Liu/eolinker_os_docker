#!/bin/bash

# 重新初始化mysql
/usr/local/mysql/scripts/mysql_install_db --defaults-file=/etc/my.cnf --basedir=/usr/local/mysql --datadir=/usr/local/mysql/var --user=mysql

# 删除锁文件
rm -f /var/lock/subsys/mysql

# 修改分组
chgrp -R mysql /usr/local/mysql/.

cd /usr/local/mysql && cp support-files/mysql.server /etc/init.d/mysql

chmod 755 /etc/init.d/mysql

# 启动mysql
service mysql start

# 重置密码
/usr/local/mysql/bin/mysqladmin -u root password 'root'

# 新建mysql数据库
mysql -uroot -proot -e "create database eolinker_os"

# 设置连接数据库权限（允许远程访问）
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION"

