# 名称：eolinker开源版本
# 用途：用于eolinker开源版本的安装
# 创建时间：2017.11.30
FROM centos
WORKDIR /root/

#安装wget
RUN yum -y install wget

#安装lnmp、unzip
RUN wget -c http://soft.vpser.net/lnmp/lnmp1.4.tar.gz && tar zxf lnmp1.4.tar.gz 
ADD main.sh lnmp1.4/include
ADD end.sh lnmp1.4/include
RUN cd lnmp1.4 && ./install.sh || true  && echo -e '\003'

RUN yum -y install unzip || true
 
# 支持中文
ENV LC_ALL en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# 替换nginx配置
ADD nginx.conf /usr/local/nginx/conf

# 将一些配置写入相应文件
RUN echo "extension=mbstring.so"   >> /etc/php.ini

#暴露80端口
EXPOSE 80
EXPOSE 3306

# 加入启动脚本
ADD service_start.sh /root
RUN cd /root && chmod +x service_start.sh

RUN mkdir /eolinker_os/ || true

ADD eolinker_os_3.5.0.zip /eolinker_os 
RUN cd /eolinker_os && unzip eolinker_os_3.5.0.zip

# 设置文件夹权限
RUN chmod -R 777 /eolinker_os && yum install -y initscripts
RUN chmod -R 777 /eolinker_os && cp /eolinker_os/server/RTP/config/version.php /root

CMD /root/service_start.sh

