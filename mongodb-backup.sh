#!/bin/bash
backup_mongod_dir=/opt/backup/mongodb
current_date=`/bin/date +%d-%m-%Y`
LIMIT_DAYS=30


for file in $(/usr/bin/find ${backup_mongod_dir} -type f ! -iname ".htaccess" -mtime +${LIMIT_DAYS} );
  do
  /bin/rm -rf $file
done


if [ ! -d "${backup_mongod_dir}/${current_date}" ];then
  /usr/bin/mkdir -p ${backup_mongod_dir}/${current_date} &&
  /usr/bin/mongodump --out ${backup_mongod_dir}/${current_date} &&
  /usr/bin/tar zcvfp ${backup_mongod_dir}/${current_date}.tgz ${backup_mongod_dir}/${current_date} &&
  /usr/bin/rm -rf ${backup_mongod_dir}/${current_date}
  exit 0
fi
