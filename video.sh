#!/bin/bash

VIDFILENAME="~/Desktop/MOV_2766.AVI"
#cutted
ffmpeg -i $VIDFILENAME -ss 00:00:11.000 -t 00:00:15.000 -c:v libx264 -c:a aac -strict experimental -b:a 128k out.mp4

#cutted and cropped
ffmpeg -i $VIDFILENAME -ss 00:00:11.000 -t 00:00:15.000 -c:v libx264 -c:a aac -strict experimental -b:a 128k -filter:v "crop=1920:1040:0:0" outc.mp4

#cut sound ogg
ffmpeg -i 'video_file.mp4' -ss 00:13:48.00 -t 3.000 -vn -acodec libvorbis out.ogg

#cut mp4 without reencode from 1 min to 6 min
ffmpeg -i big_file.mp4 -ss 00:01:00 -to 00:06:00 -acodec copy -vcodec copy out.mp4
