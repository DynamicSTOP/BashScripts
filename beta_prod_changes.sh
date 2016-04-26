#!/bin/bash

PROJECT_PATH="my-project-folder-name"

BETA_PATH="/var/www/beta.$PROJECT_PATH/"
LIVE_PATH="/var/www/$PROJECT_PATH/"

TMP_FL="/tmp/golive"

diff -bur $LIVE_PATH $BETA_PATH > results.diff

cat results.diff | grep "+++" | sed "s/\t/ /g"| sed "s/\/var\/www\/beta.$PROJECT_PATH\///g" | cut -d" " -f2 > $TMP_FL
while read line; do echo "cp ${BETA_PATH}${line} ${LIVE_PATH}${line}";
done < $TMP_FL

cat results.diff | grep "^Only in" | sed "s/^/#/g"

rm $TMP_FL
