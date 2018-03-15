for combo in $(cat vendor/celtic/device.targets | sed -e 's/#.*$//' | awk {'print $1'})
do
 add_lunch_combo celtic_$combo
done
