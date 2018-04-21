cd ~/

git clone https://github.com/FlySnowIII/edusohomooc.git

sudo docker pull flysnowiii/edusohomooc

sudo docker run -it --name=edusohomooc -p 10080:80 -p 13306:3306 -v ~/edusohomooc/files:/var/www/edusoho/web/files -v ~/edusohomooc/mysql:/mysqlbak flysnowiii/edusohomooc /bin/bash

bash runserver.sh
ctl + P,Q

sudo docker exec edusohomooc bash runserver.sh

sudo docker exec edusohomooc bash bakupmysql.sh

sudo docker exec edusohomooc bash changetophpmyadmin.sh

sudo docker exec edusohomooc bash changetoweb.sh


DB:
root:0pp00pp0
edusoho:edusoho

Mooc:
admin
0pp00pp0
admin@studymooc.com