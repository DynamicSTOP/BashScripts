# Disables touch once wacom tablet is connected via usb in Ubuntu 22

#assuming your username is "myuser"

# first run
lsub
# one of the lines would be smth like
# Bus 001 Device 007: ID 056a:0357 Wacom Co., Ltd PTH-660 [Intuos Pro (M)]
# remember numbers 056a:0357 

# now make sure wacom bins are there with this command 
xsetwacom  --list
# you'll get something like that
#Wacom Intuos Pro M Pad pad      	id: 24	type: PAD       
#Wacom Intuos Pro M Pen stylus   	id: 25	type: STYLUS    
#Wacom Intuos Pro M Pen eraser   	id: 26	type: ERASER    
#Wacom Intuos Pro M Finger touch 	id: 27	type: TOUCH

#test it with (use your device name from previous command output)
xsetwacom --set "Wacom Intuos Pro M Finger touch" Touch off

# go to your home dir and add a file /home/myuser/wacom.sh
#!/usr/bin/bash
export DISPLAY=:0
export XAUTHORITY=/home/leonid/.Xauthority
/usr/bin/xsetwacom --set "Wacom Intuos Pro M Finger touch" Touch off

# If you get errors regarding display can't be open or smth
# run this in console
echo $DISPLAY
# then check if it's same as in export (thanks debian)

# now make a file /etc/udev/rules.d/99-snap.wacom.rules with following line  (use your username and number from before)
SUBSYSTEMS=="usb", ACTION=="add", ATTRS{idVendor}=="056a", ATTRS{idProduct}=="0357", OWNER="myuser", RUN+="/usr/bin/su myuser /home/myuser/wacom.sh"

#reload rules with 
udevadm control --reload-rules && udevadm trigger

# looking for errors?
udevadm control --log-priority=debug
journalctl -f
# and plug\unplug your tablet 

# i hope it helped 
# also i guess that /home/myuser/wacom.sh better be readonly and only editable by admin? geh.. nobody touches my laptop so whatever 
