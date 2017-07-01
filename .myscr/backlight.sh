logfile='backlight.log';
# change brightness if the square of the difference is bigger than thresh
thresh=16;
# lowest value to set in any situation
lowest=8;
#delaytime in xbacklight milliseconds
delaytime=500
#set up the watch
#the device acknowledges new value only when it is refreshed, e.g. through cat
# 4 sec sounds good enough
# only the accelerometer data, not light (device0)
watch -n 4 cat /sys/bus/iio/devices/iio\:device0/*raw* > /dev/null 2>&1 &
echo $!

#clear the old logfile
echo '' > $logfile
# Saving the output in a file
monitor-sensor >> $logfile 2>&1 &

#when the file is modified, take action
 while inotifywait -e modify $logfile;
 do 
	 # to grab accelerator data, filter out the light data
	 # in that case, have to add | Grep Accel beforehand
	 # breaking the last line to find the direction
	 lightval=$(tail -n 1 $logfile | grep Light | awk -F ' ' '{ print $3}');

	 #add a condition to check if direction in nonempty
	 if [ -n "$lightval" ];
	 then	 echo $lightval;
		 #linear, slope = 0.2, y-int= 10
		 #values bigger than 100 is considered 100 for xbacklight
		 brightval=`echo "$lightval * 0.2 + $lowest" | bc`;
		 currval=$(xbacklight -get);
		 change=`echo '('$brightval - $currval ')^2 >' $thresh | bc -l`;
		 if [ "$change" -eq 1 ];
			 then xbacklight -set $brightval -time $delaytime;
		 fi
		 echo $currval;
	 fi
 done

