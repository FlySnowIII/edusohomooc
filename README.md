# Docker Image 构建方法

## 1.目的

基于Ubuntu镜像创建自己的镜像文件，并分享到hub.docker.com上。

***

## 2.概述

Docker是什么就不在这里赘述了。

本教程所实现的效果如果举个简单的例子的话可以理解为类似把"本地文件夹打包压缩然后上传到网盘"的过程。

* 具体过程可以分为如下几步：

    1. 创建本地文件夹：拉取Ubuntu镜像，基于Ubuntu镜像在本地创建一个Ubuntu容器(关键：设置开放端口号与共享文件夹)
    1. 在本地文件夹内创建文件：在Ubuntu容器内安装Apache2,Mysql与Php和本次将要打包的EduSoho Mooc系统
    1. 压缩文件夹：将Ubuntu容器打包成一个镜像文件
    1. 上传到网盘：想打包后的镜像文件推送到hub.docker.com上

* 检验并使用：

    1. 在另一台电脑下载压缩文件：从hub.docker.com上拉取自己打包的镜像文件
    1. 在本地解压压缩文件：基于自己打包的镜像文件，创建一个容器，同时设置其开放端口号与共享文件夹
    1. 执行解压后文件夹内的文件：进入该容器，通过命令行启动Web服务
    1. 关闭文件夹：退出容器的命令行状态，但要保持容器不被停止

***

## 3.所需知识
1. Docker中镜像，容器与卷的概念
1. Docekr命令行

***

## 4.具体实施

### 前期处理：安装Docker

~~~bash
sudo apt update
sudo apt upgrade 
sudo apt install docker.io
sudo docker ps -a
~~~

### A. 打包镜像：

1. 创建本地文件夹：拉取Ubuntu镜像，基于Ubuntu镜像在本地创建一个Ubuntu容器(关键：设置开放端口号与共享文件夹):

    1. 拉取Ubuntu镜像

    ~~~bash
    sudo docker pull ubuntu
    sudo docker images
    ~~~  
    
    2. 创建一个Ubuntu容器,并设置开放端口号与共享文件夹

    ~~~bash
    cd ~/
    mkdir caddymooc
    cd caddymooc
    mkdir files
    mkdir mysql
    sudo docker run -it --name=caddymooc \
                        -p 10080:80 -p 13306:3306 \
                        -v ~/caddymooc/files:/var/www/edusoho/web/files \
                        -v ~/caddymooc/mysql:/mysqlbak \
                        ubuntu /bin/bash
    ~~~

1. 在本地文件夹内创建文件：在Ubuntu容器内安装Apache2,Mysql与Php和本次将要打包的EduSoho Mooc系统:
    
    * 详情参考[bash](bash/)目录

1. 压缩文件夹：将Ubuntu容器打包成一个镜像文件:

    ~~~bash
    sudo docker commit -a 'Pengfei' -m 'edusoho apache2' caddymooc flysnowiii/edusohomooc    
    ~~~

1. 上传到网盘：把打包后的镜像文件推送到hub.docker.com上:
    1. 在浏览器上登陆 hub.docker.com 并创建一个新栈(Create Repository)
    ~~~
    https://hub.docker.com/add/repository/
    ※(本项目命名为：edusohomooc)
    ~~~
    
    2. 登陆 hub.docker.com
    ~~~bash
    sudo docker login
    ~~~

    a. 如果连接不上hub.docker.com的域名服务器，请执行如下代码
    ~~~bash
    sudo vim /etc/resolvconf/resolv.conf.d/head 
    ~~~

    b. 添加一行
    ~~~bash
    nameserver 8.8.8.8
    ~~~

    c. 重启
    ~~~bash
    sudo reboot
    ~~~

    3. 把打包后的镜像文件推送到hub.docker.com上
    ~~~bash
    docker push flysnowiii/edusohomooc
    ~~~

### B. 还原镜像

1. 在另一台电脑下载压缩文件：从hub.docker.com上拉取自己打包的镜像文件

    ~~~bash
    sudo docker pull flysnowiii/edusohomooc
    ~~~


1. 在本地解压压缩文件：基于自己打包的镜像文件，创建一个容器，同时设置其开放端口号与共享文件夹

    ~~~bash
    cd ~/
    git clone https://github.com/FlySnowIII/edusohomooc.git

    sudo docker run -it --name=edusohomooc -p 10080:80 -p 13306:3306 -v ~/edusohomooc/files:/var/www/edusoho/web/files -v ~/edusohomooc/mysql:/mysqlbak flysnowiii/edusohomooc /bin/bash
    ~~~

1. 执行解压后文件夹内的文件：进入该容器，通过命令行启动Web服务

    ~~~
    bash runserver.sh
    ~~~

1. 关闭文件夹：退出容器的命令行状态，但要保持容器不被停止

    ~~~
    ( 按 ctl + P,Q 退出 )
    ~~~

## 5.其他信息
1. Github信息
    ~~~
    https://github.com/FlySnowIII/edusohomooc
    ~~~

1. hub.docker.com 信息
    ~~~
    https://hub.docker.com/r/flysnowiii/edusohomooc/
    ~~~

1. flysnowiii/edusohomooc预设指令
    ~~~bash
    #运行/重启服务
    sudo docker exec edusohomooc bash runserver.sh

    #备份当前数据库
    sudo docker exec edusohomooc bash bakupmysql.sh

    #将服务切换为phpmyadmin模式
    sudo docker exec edusohomooc bash changetophpmyadmin.sh

    #将服务切换为mooc网站模式
    sudo docker exec edusohomooc bash changetoweb.sh
    ~~~
