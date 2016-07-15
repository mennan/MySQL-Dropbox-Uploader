#!/bin/sh

DAY=`/bin/date +%Y%m%d`

echo "Backup has started."
echo "MySQL databases backuping..."

mysqldump -u USERNAME -pPASSWORD --all-databases > /tmp/mysql.backup.$DAY.sql

echo "MySQL backup completed."
echo "Compressing MySQL database backup files..."

tar -czvf /tmp/$DAY.mysql.tar.gz /tmp/*.sql

echo "Compress completed."

rm -f /tmp/*.sql

echo "Uploading backup files to DropBox..."

./dropbox_uploader.sh upload /tmp/*.tar.gz /

echo "Upload completed."

rm -f /tmp/*.tar.gz

echo "Compressing web sites..."

tar -czvf /tmp/$DAY.websites.tar.gz /var/www/

echo "Compress completed."
echo "Upload web site backup files to DropBox..."

./dropbox_uploader.sh upload /tmp/*.tar.gz /

echo "Upload completed."

rm -f /tmp/*.tar.gz