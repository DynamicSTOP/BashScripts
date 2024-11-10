#!/bin/bash
#
# in a folder with a lot of file likes "Aksjaklsfj m asdw 1000.jpg"  -> "1000.jpg"
# 

for file in *.jpg
do fnew=`echo $file | grep -oa "[0-9]\+\.jpg"`
mv "./$file" $fnew
done
