. build/envsetup.sh
function build_kernel(){
  make kernel
}
function build_zip()
{
  echo "Build zip now?"
  read i
  case $i in
    Y|y)
    make buildzip
    ;;
    N|n)
    ;;
  esac
}
echo "Please choose your device"
lunch
echo "Building source. Please wait."
build_kernel 1> ./build-log-$RENDER_PRODUCT.log 2>&1
if [ $OUT_DIR/$RENDER_PRODUCT/zImage ]; then
  clear
  echo "Built successful"
  built=1
else
  built=0
fi
case $built in
  0 )
  echo "Please check ./build-log-$RENDER_PRODUCT.log for errors in unsuccessful build"
  break
  ;;
  1 )
  echo "Following files have been successfuly created"
  ls -R $OUT_DIR/$RENDER_PRODUCT
  build_zip
  ;;
esac
