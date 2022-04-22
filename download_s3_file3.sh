#!/bin/bash
file=$1
bucket=munki-repo-test
resource="/${bucket}/${file}"
S3_ACCESS_KEY=
S3_SECRET_KEY=
dateValue=$(date -R -u +'%a, %d %b %Y %H:%M:%S %z')
dateValue=$(LC_ALL=en_US.UTF-8 date -R -u +'%a, %d %b %Y %H:%M:%S %z')
stringToSign="GET\n\n\n${dateValue}\n${resource}"
signature=$(echo -en "${stringToSign}" | openssl sha1 -hmac "${S3_SECRET_KEY}" -binary | base64)
curl -X GET -H "Host: ${bucket}.s3.amazonaws.com" -H "Date: ${dateValue}" -H "Authorization: AWS ${S3_ACCESS_KEY}:${signature}" "https://${bucket}.s3.amazonaws.com/${file}"

