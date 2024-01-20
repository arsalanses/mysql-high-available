#!/bin/sh

# set up the date variable
NOW=$(date +%Y%m%d%H%M%S)
BINLOG_BACKUP=${NOW}_binlog.tar.gz

# set up the database credentials
DB_USER=root
DB_PASSWORD=root_password

# binary log files directory path
BINLOGS_PATH=/var/log/mysql/

# flush the current log and start writing to a new binary log file
mysql -u$DB_USER -p$DB_PASSWORD -E --execute='FLUSH BINARY LOGS;' mysql

# get a list of all binary log files
BINLOGS=$(mysql -u$DB_USER -p$DB_PASSWORD -E --execute='SHOW BINARY LOGS;' mysql | grep Log_name | sed -e 's/Log_name://g' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

# get the most recent binary log file
BINLOG_CURRENT=`echo "${BINLOGS}" | tail -n -1`

# get list of binary logs to be backed up (everything except the most recent one)
BINLOGS_FOR_BACKUP=`echo "${BINLOGS}" | head -n -1`

# create a list of the full paths to the binary logs to be backed up
BINLOGS_FULL_PATH=`echo "${BINLOGS_FOR_BACKUP}" | xargs -I % echo $BINLOGS_PATH%`

# compress the list of binary logs to be backed up into an archive in the backup location
tar -czvf /sites/backups/$BINLOG_BACKUP $BINLOGS_FULL_PATH

# delete the binary logs that have been backed up
echo $BINLOG_CURRENT | xargs -I % mysql -u$DB_USER -p$DB_PASSWORD -E --execute='PURGE BINARY LOGS TO "%";' mysql
