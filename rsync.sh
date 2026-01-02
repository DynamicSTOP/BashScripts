#!/bin/bash
# assuming both folders exists
# will do recursive copy insides of source folder into destination folder 
rsync -av /home/username/source_folder/ /media/destination/folder/

#10mb per sec limit
rsync -av --bwlimit=10M /home/username/source_folder/ /media/destination/folder/

