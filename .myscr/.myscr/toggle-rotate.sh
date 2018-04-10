#!/bin/bash
# Auto-rotate for Lenovo Yoga 720 13"
# Dependency: iio-sensors-proxy, ~/.myscr/rotate
logfile='accel.log';
#set up the watch
#the device acknowledges new value only when it is refreshed, e.g. through cat
# 4 sec sounds good enough
# only the accelerometer data, not light (device0)
watch -n 4 cat /sys/bus/iio/devices/iio\:device*/*accel*raw* > /dev/null 2>&1 &
echo $!

#clear the old logfile
rm $logfile
# Saving the output in a file
monitor-sensor | grep --line-buffered 'Accel' | awk -F ': ' '{print $2; fflush(stdout)}' | awk -F '-' '{ print $1;fflush(stdout)}' >> $logfile 2>&1 &

#when the file is modified, take action
 while inotifywait -e modify $logfile;
 do 
	 # to grab accelerator data, filter out the light data
	 # in that case, have to add | Grep Accel beforehand
	 # breaking the last line to find the direction
	 direction=$(tail -n 1 $logfile);

	 #add a condition to check if direction in nonempty
	 if [ -n "$direction" ];
		 then ~/.myscr/rotate $direction; 
	 fi
 done

