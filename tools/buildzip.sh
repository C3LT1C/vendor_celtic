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
  while read -p "Build zip now  [Y|y or N|n]? " i
  do
  echo ""
  case $i in
    Y|y )
    if [ "$TARGET_BUILD_VARIANT" == "bootimg" ]; then
      make buildbootimg
    fi
    make buildzip
    make printcompletion
    break
    ;;
    N|n )
    break
    ;;
    * )
    echo "Invalid entry"
    echo ""
    ;;
  esac
  done
}
unset synced
while read -p "Sync sources [Y|y or N|n]? " b
do
echo ""
case $b in
  Y|y )
  sync_source
  break
  ;;
  N|n )
  break
  ;;
  * )
  echo "Invalid entry"
  echo ""
  ;;
esac
done
source build/envsetup.sh
echo "Please choose your device"
lunch
if [ "$synced" ]; then
  make kernelclean
fi
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
  if [ "$TARGET_BUILD_VARIANT" != "kernel" ]; then
  build_zip
  else
  echo "Built zImage"
  echo "Skipping zip creation ..."
  fi
  ;;
esac
