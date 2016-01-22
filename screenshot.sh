#!/bin/bash
CURRENTTIME=(`date +%s`)
sleep 5
import -window root ~/screenshot/screen_${CURRENTTIME}.jpg
