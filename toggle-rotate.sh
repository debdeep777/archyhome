
#set up the watch
#the device acknowledges new value only when it is refreshed, e.g. through cat
# 4 sec sounds good enough
# only the accelerometer data, not light (device0)
watch -n 4 cat /sys/bus/iio/devices/iio\:device1/*raw* > /dev/null 2>&1 &
echo $!
# Saving the output in a file
monitor-sensor >> accel.log 2>&1 &

#when the file is modified, take action
 while inotifywait -e modify accel.log;
 do 
	 # to grab accelerator data, filter out the light data
	 # in that case, have to add | Grep Accel beforehand
	 # breaking the last line to find the direction
	 direction=$(tail -n 1 accel.log | grep Accel | awk -F ': ' '{ print $2}' | awk -F '-' '{ print $1}');

	 #add a condition to check if direction in nonempty
	 if [ -n "$direction" ];
		 then rotate $direction; 
	 fi
 done

