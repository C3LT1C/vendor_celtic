for combo in $(curl -s https://raw.githubusercontent.com/RenderKernels/build-targets/master/products | sed -e 's/#.*$//' | awk {'print $1'})
do
 echo -e "\033[32m" $combo"\033[0m"
done
