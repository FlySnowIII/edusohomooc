#!/bin/bash

chown -Rf www-data:www-data /var/www/edusoho/

service mysql start
service apache2 start
