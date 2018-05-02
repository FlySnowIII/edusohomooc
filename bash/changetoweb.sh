#!/bin/bash

mv /etc/apache2/sites-enabled/phpmyadmin.conf /etc/apache2/sites-enabled/phpmyadmin.conf.bak
mv /etc/apache2/sites-enabled/edusoho.conf.bak /etc/apache2/sites-enabled/edusoho.conf
service apache2 restart
