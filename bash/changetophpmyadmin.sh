#!/bin/bash

mv /etc/apache2/sites-enabled/phpmyadmin.conf.bak /etc/apache2/sites-enabled/phpmyadmin.conf
mv /etc/apache2/sites-enabled/edusoho.conf /etc/apache2/sites-enabled/edusoho.conf.bak
service apache2 restart
