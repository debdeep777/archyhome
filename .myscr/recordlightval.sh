# record lightsensor value in lux and preferred set brightness
# at different time of the day to create an optimal profile for auto-brightness
va=$(cat  /sys/bus/iio/devices/iio\:device*/*intensity*raw*);
sleep 0.1
vb=$(cat  /sys/bus/iio/devices/iio\:device*/*intensity*raw*);
sleep 0.1
vc=$(cat  /sys/bus/iio/devices/iio\:device*/*intensity*raw*);
sleep 0.1
vd=$(cat  /sys/bus/iio/devices/iio\:device*/*intensity*raw*);
avglux=$( echo '('$va + $vb + $vc + $vd ')/4' | bc -l);
brightval=$(xbacklight -get);

import -window root -resize 25% screencapture.png;
windowavg=$(convert screencapture.png -colorspace gray -format "%[fx:100*mean]" info:);
rm screencapture.png;

# Date, Time, Ambient Light (lux), Current brightness value, Avg pixel luminosity
echo $(date +'%Y-%m-%d,%H:%M:%S'),$avglux','$brightval','$windowavg >> 'lightdata'
