DEFCONFIG=cyanogen_cancro_defconfig
OBJ_DIR=`pwd`/.obj
ANYKERNEL_DIR=${HOME}/AnyKernel2
TOOLCHAIN=${HOME}/toolchain/arm-linux-androideabi-4.9/bin/arm-linux-androidkernel-
WEB_SERVER_ROOT=/srv/http/
DATE=$(date +"%m-%d-%y")

if [ ! -d ${OBJ_DIR} ]; then
    mkdir ${OBJ_DIR}
fi

make ARCH=arm O=$OBJ_DIR CROSS_COMPILE=${TOOLCHAIN} $DEFCONFIG
make -j$(grep -c ^processor /proc/cpuinfo) ARCH=arm O=$OBJ_DIR CROSS_COMPILE=${TOOLCHAIN}
rm -f ${ANYKERNEL_DIR}/zImage*
rm -f ${ANYKERNEL_DIR}/dtb*
cp $OBJ_DIR/arch/arm/boot/zImage-dtb ${ANYKERNEL_DIR}
cp $OBJ_DIR/drivers/staging/prima/wlan.ko ${ANYKERNEL_DIR}/modules
cd ${ANYKERNEL_DIR}
rm *.zip
zip -r9 ZeurionX-$DATE.zip * -x README ZeurionX-$DATE.zip
cp Z* ${WEB_SERVER_ROOT}
