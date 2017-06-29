notify-send "Hi"
# Auto rotate screen based on device orientation
##########
# Dependency: 
###sudo apt install iio-sensor-proxy inotify-tools
#
# Receives input from monitor-sensor (part of iio-sensor-proxy package)
# Screen orientation and launcher location is set based upon accelerometer position
# Launcher will be on the left in a landscape orientation and on the bottom in a portrait orientation
# This script should be added to startup applications for the user

########################
# /need to run 
watch -n 4 cat '/sys/bus/iio/devices/iio:device'*/*raw* >> NULL &
echo $!
#as a workaround beforehand

# Clear sensor.log so it doesn't get too long over time
> sensor.log

# Launch monitor-sensor and store the output in a variable that can be parsed by the rest of the script
monitor-sensor >> sensor.log 2>&1 &

# Parse output or monitor sensor to get the new orientation whenever the log file is updated
# Possibles are: normal, bottom-up, right-up, left-up
# Light data will be ignored
while inotifywait -e modify sensor.log; do
	# Read the last line that was added to the file and get the orientation
	ORIENTATION=$(tail -n 1 sensor.log | grep 'orientation' | grep -oE '[^ ]+$')

	# Set the actions to be taken for each possible orientation
	case "$ORIENTATION" in
		normal)
			~/rotate normal;;
		bottom-up)
			~/rotate inverted;;
		right-up)
			~/rotate right;;
		left-up)
			~/rotate left;;
	esac
done
