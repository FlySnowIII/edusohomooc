#!/bin/bash

BACKUP_DIR=/mysqlbak/
BACKUP_DB_FILE_NAME=mooc-`/bin/date +%Y-%m-%d`.dump

mysqldump --single-transaction -u root -p"0pp00pp0" edusoho > $BACKUP_DIR$BACKUP_DB_FILE_NAME
