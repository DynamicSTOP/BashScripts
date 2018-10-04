#!/bin/bash

VIDFILENAME="~/Desktop/MOV_2766.AVI"
#cutted
ffmpeg -i $VIDFILENAME -ss 00:00:11.000 -t 00:00:15.000 -c:v libx264 -c:a aac -strict experimental -b:a 128k out.mp4

#cutted and cropped
ffmpeg -i $VIDFILENAME -ss 00:00:11.000 -t 00:00:15.000 -c:v libx264 -c:a aac -strict experimental -b:a 128k -filter:v "crop=1920:1040:0:0" outc.mp4

#cut sound ogg
ffmpeg -i 'video_file.mp4' -ss 00:13:48.00 -t 3.000 -vn -acodec libvorbis out.ogg
