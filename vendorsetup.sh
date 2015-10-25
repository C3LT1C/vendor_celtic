for combo in $(curl -s https://raw.githubusercontent.com/RenderKernels/build-targets/lp5.1/products | sed -e 's/#.*$//' | awk {'print $1'})
do
 add_lunch_combo render_$combo
done
