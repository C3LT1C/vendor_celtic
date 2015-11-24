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
  make kernelclobber
fi
echo "Building source. Please wait."
if build_kernel 1> ./build-log-$RENDER_PRODUCT.log 2>&1 ; then
  clear
  echo "Built successful"
  if [ "$TARGET_BUILD_VARIANT" != "kernel" ]; then
  build_zip
  else
  echo "Skipping zip creation ..."
  fi
else
    echo "Errors at the following lines; Build unsuccessful"
  for line in $(grep -n "error" ./build-log-$RENDER_PRODUCT.log | cut -f1 -d:)
  do
    cat ./build-log-$RENDER_PRODUCT.log | sed "${line}!d"
  done
  echo "Check ./build-log-$RENDER_PRODUCT.log for verbosity"
fi
