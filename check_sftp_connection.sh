#!/bin/bash

# Autor: Jeancarlo Silva
# This script check SFTP connection sending a file and after check this file uploaded
# 2016-08-18 - Initial version

TMP_FILE="/tmp/check_sftp.`date "+%s"`"

(
/usr/bin/expect<<EOD

set timeout 1
log_file $TMP_FILE

spawn /usr/bin/sftp user@sftp.contoso.com
expect "sftp>"
send "cd upload \r"
expect "sftp>"
send "ls \r"
expect "sftp>"
send "bye \r"
EOD
) > /dev/null 2>&1

grep "^old" $TMP_FILE > /dev/null
if [ $? -eq 0 ]; then
  echo "FTP Connection OK"
  rm $TMP_FILE
  exit 0
else
  echo "FTP Connection ERROR"
  exit 2
fi

