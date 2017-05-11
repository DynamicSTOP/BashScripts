#!/bin/bash

VIDFILENAME="~/Desktop/MOV_2766.AVI"
#cutted
/home/leonid/ffmpeg-2.2.4-64bit-static/ffmpeg -i $VIDFILENAME -ss 00:00:11.000 -t 00:00:15.000 -c:v libx264 -c:a aac -strict experimental -b:a 128k out.mp4

#cutted and cropped
/home/leonid/ffmpeg-2.2.4-64bit-static/ffmpeg -i $VIDFILENAME -ss 00:00:11.000 -t 00:00:15.000 -c:v libx264 -c:a aac -strict experimental -b:a 128k -filter:v "crop=1920:1040:0:0" outc.mp4
