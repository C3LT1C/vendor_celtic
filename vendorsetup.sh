for combo in $(cat vendor/black/device.targets | sed -e 's/#.*$//' | awk {'print $1'})
do
 add_lunch_combo black_$combo
done
