#!/bin/bash
BASEDIR=`dirname $0`
cd ${BASEDIR}/..
while :; do
  date >> log/stream.log
  /usr/bin/npm run start >> log/stream.log 2>&1
done
