#!/bin/bash
export DUMP_START_TIME=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
export FILE_TO_BK="${DUMP_START_TIME}.dump.sql.gz"
export DUMP_FILE="/tmp/${FILE_TO_BK}"

export AWS_ACCESS_KEY_ID=$S3_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$S3_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$S3_REGION

echo "[MySQL-BK-S3-FTP]: Generate Dump File"

mysqldump -h $MYSQL_HOST -P $MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASS $MYSQLDUMP_OPTIONS $MYSQLDUMP_DATABASE | gzip > $DUMP_FILE

echo "[MySQL-BK-S3-FTP]: Upload to S3"
if [[ -z "${S3_FILE_NAME}" ]]; then
    S3_FILE_NAME=$FILE_TO_BK
fi

aws s3 cp $DUMP_FILE s3://$S3_BUCKET/$S3_PREFIX/$S3_FILE_NAME

echo "[MySQL-BK-S3-FTP]: Upload to FTP Server"
if [[ -z "${FTP_FILE_NAME}" ]]; then
    FTP_FILE_NAME=$FILE_TO_BK
else
    mv $DUMP_FILE $FTP_FILE_NAME
fi

curl $FTP_OPTIONS -T $FTP_FILE_NAME -u $FTP_USER:$FTP_PASS ftp://$FTP_HOST/$FTP_PATH/