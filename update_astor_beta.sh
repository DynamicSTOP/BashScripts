#!/bin/bash

#
# this little fellow will take filenames from log and make a bash script
# that will upload files using scp
#
# cons for me it will ask for key password once

if ( [ -z $1 ] ) then
 com_num='1'
else
 com_num=$1
fi

SERVER_PATH="myserver:/path/to/folder/on/server/"
PROJECT_PATH="/my/local/path/"

TMP_FL="/tmp/git-myprojectname"

cd $PROJECT_PATH
git log -n ${com_num} --name-only --format="%n" | sed "/^$/d" | sort | uniq  > $TMP_FL

echo '#!/bin/bash'
echo
while read line; do echo "scp ${PROJECT_PATH}${line} ${SERVER_PATH}${line}";
done < $TMP_FL

rm $TMP_FL
