function sync_source()
{
  repo sync -f
  synced=1
}
function build_kernel()
{
  make kernel
}
function build_zip()
{
  echo "Build zip now?"
  read i
  case $i in
    Y|y)
    make buildzip
    make printcompletion
    ;;
    N|n)
    ;;
  esac
}
echo "Sync sources?"
read b
case $b in
  Y|y)
  sync_source
  ;;
  N|n)
  ;;
esac
source build/envsetup.sh
echo "Please choose your device"
if [ "$synced" ]; then
  make kernelclean
fi
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
  build_zip
  ;;
esac
