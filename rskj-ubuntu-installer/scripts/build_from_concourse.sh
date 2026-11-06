#!/bin/bash

#
# before run this script install git, debhelper, lintian and dpkg-dev
#

if [ -z "$1" ]; then
	echo "Argument rskj node jar not supplied"
	exit 2
elif [ -f "$1" ]; then
	FILE_NAME_NODE=$1
else
	echo "rskj node jar not exists"
	exit 2
fi

if [ -z "$2" ]; then
	echo "Argument version not supplied"
	exit 2
else
	VERSION=$2
fi

RFCDATE=$(date --rfc-2822)

USER=$(whoami)
#HOME=$(eval echo "~$USER")

echo "Im here"
echo $PWD

WORKSPACE=$(echo "$HOME/$VERSION")

echo "Workspace here"
echo $WORKSPACE
mkdir -p $WORKSPACE/source

mkdir -p $WORKSPACE/source/{bionic,jammy,focal,noble,resolute,stonking}/rskj_$VERSION

cp -r rskj_package_focal/. $WORKSPACE/source/focal/rskj_$VERSION/
cp -r rskj_package_bionic/. $WORKSPACE/source/bionic/rskj_$VERSION/
cp -r rskj_package_jammy/. $WORKSPACE/source/jammy/rskj_$VERSION/
cp -r rskj_package_noble/. $WORKSPACE/source/noble/rskj_$VERSION/
cp -r rskj_package_resolute/. $WORKSPACE/source/resolute/rskj_$VERSION/
cp -r rskj_package_stonking/. $WORKSPACE/source/stonking/rskj_$VERSION/

sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/focal/rskj_$VERSION/debian/control
sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/focal/rskj_$VERSION/debian/changelog
sed -i "s|<DATE>|${RFCDATE}|g" $WORKSPACE/source/focal/rskj_$VERSION/debian/changelog

sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/bionic/rskj_$VERSION/debian/control
sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/bionic/rskj_$VERSION/debian/changelog
sed -i "s|<DATE>|${RFCDATE}|g" $WORKSPACE/source/bionic/rskj_$VERSION/debian/changelog

sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/jammy/rskj_$VERSION/debian/control
sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/jammy/rskj_$VERSION/debian/changelog
sed -i "s|<DATE>|${RFCDATE}|g" $WORKSPACE/source/jammy/rskj_$VERSION/debian/changelog

sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/noble/rskj_$VERSION/debian/control
sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/noble/rskj_$VERSION/debian/changelog
sed -i "s|<DATE>|${RFCDATE}|g" $WORKSPACE/source/noble/rskj_$VERSION/debian/changelog

sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/resolute/rskj_$VERSION/debian/control
sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/resolute/rskj_$VERSION/debian/changelog
sed -i "s|<DATE>|${RFCDATE}|g" $WORKSPACE/source/resolute/rskj_$VERSION/debian/changelog

sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/stonking/rskj_$VERSION/debian/control
sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/stonking/rskj_$VERSION/debian/changelog
sed -i "s|<DATE>|${RFCDATE}|g" $WORKSPACE/source/stonking/rskj_$VERSION/debian/changelog

cp $FILE_NAME_NODE $WORKSPACE/source/focal/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/bionic/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/jammy/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/noble/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/resolute/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/stonking/rskj_$VERSION/src/rsk.jar

cp config/regtest.conf $WORKSPACE/source/focal/rskj_$VERSION/src/regtest.conf
cp config/mainnet.conf $WORKSPACE/source/focal/rskj_$VERSION/src/mainnet.conf
cp config/testnet.conf $WORKSPACE/source/focal/rskj_$VERSION/src/testnet.conf
cp config/logback.xml $WORKSPACE/source/focal/rskj_$VERSION/src/
cp init-scripts/rsk.service-node $WORKSPACE/source/focal/rskj_$VERSION/src/rsk.service

cp config/regtest.conf $WORKSPACE/source/bionic/rskj_$VERSION/src/regtest.conf
cp config/mainnet.conf $WORKSPACE/source/bionic/rskj_$VERSION/src/mainnet.conf
cp config/testnet.conf $WORKSPACE/source/bionic/rskj_$VERSION/src/testnet.conf
cp config/logback.xml $WORKSPACE/source/bionic/rskj_$VERSION/src/
cp init-scripts/rsk.service-node $WORKSPACE/source/bionic/rskj_$VERSION/src/rsk.service

cp config/regtest.conf $WORKSPACE/source/jammy/rskj_$VERSION/src/regtest.conf
cp config/mainnet.conf $WORKSPACE/source/jammy/rskj_$VERSION/src/mainnet.conf
cp config/testnet.conf $WORKSPACE/source/jammy/rskj_$VERSION/src/testnet.conf
cp config/logback.xml $WORKSPACE/source/jammy/rskj_$VERSION/src/
cp init-scripts/rsk.service-node $WORKSPACE/source/jammy/rskj_$VERSION/src/rsk.service

cp config/regtest.conf $WORKSPACE/source/noble/rskj_$VERSION/src/regtest.conf
cp config/mainnet.conf $WORKSPACE/source/noble/rskj_$VERSION/src/mainnet.conf
cp config/testnet.conf $WORKSPACE/source/noble/rskj_$VERSION/src/testnet.conf
cp config/logback.xml $WORKSPACE/source/noble/rskj_$VERSION/src/
cp init-scripts/rsk.service-node $WORKSPACE/source/noble/rskj_$VERSION/src/rsk.service

cp config/regtest.conf $WORKSPACE/source/resolute/rskj_$VERSION/src/regtest.conf
cp config/mainnet.conf $WORKSPACE/source/resolute/rskj_$VERSION/src/mainnet.conf
cp config/testnet.conf $WORKSPACE/source/resolute/rskj_$VERSION/src/testnet.conf
cp config/logback.xml $WORKSPACE/source/resolute/rskj_$VERSION/src/
cp init-scripts/rsk.service-node $WORKSPACE/source/resolute/rskj_$VERSION/src/rsk.service

cp config/regtest.conf $WORKSPACE/source/stonking/rskj_$VERSION/src/regtest.conf
cp config/mainnet.conf $WORKSPACE/source/stonking/rskj_$VERSION/src/mainnet.conf
cp config/testnet.conf $WORKSPACE/source/stonking/rskj_$VERSION/src/testnet.conf
cp config/logback.xml $WORKSPACE/source/stonking/rskj_$VERSION/src/
cp init-scripts/rsk.service-node $WORKSPACE/source/stonking/rskj_$VERSION/src/rsk.service

echo "####################################################"
echo "#                  BUILD STONKING                  #"
echo "####################################################"
cd $WORKSPACE/source/stonking/rskj_$VERSION
debuild -us -uc -S

echo "####################################################"
echo "#                  BUILD RESOLUTE                  #"
echo "####################################################"
cd $WORKSPACE/source/resolute/rskj_$VERSION
debuild -us -uc -S

echo "####################################################"
echo "#                   BUILD NOBLE                    #"
echo "####################################################"
cd $WORKSPACE/source/noble/rskj_$VERSION
debuild -us -uc -S

echo "####################################################"
echo "#                   BUILD JAMMY                    #"
echo "####################################################"
cd $WORKSPACE/source/jammy/rskj_$VERSION
debuild -us -uc -S

echo "####################################################"
echo "#                   BUILD FOCAL                    #"
echo "####################################################"
cd $WORKSPACE/source/focal/rskj_$VERSION
debuild -us -uc -S

echo "####################################################"
echo "#                   BUILD BIONIC                    #"
echo "####################################################"
cd $WORKSPACE/source/bionic/rskj_$VERSION
debuild -us -uc -S

mkdir -p $WORKSPACE/build/{bionic,jammy,focal,noble,resolute,stonking}

mv $WORKSPACE/source/bionic/rskj_$VERSION* $WORKSPACE/build/bionic/
mv $WORKSPACE/source/jammy/rskj_$VERSION* $WORKSPACE/build/jammy/
mv $WORKSPACE/source/focal/rskj_$VERSION* $WORKSPACE/build/focal/
mv $WORKSPACE/source/noble/rskj_$VERSION* $WORKSPACE/build/noble/
mv $WORKSPACE/source/resolute/rskj_$VERSION* $WORKSPACE/build/resolute/
mv $WORKSPACE/source/stonking/rskj_$VERSION* $WORKSPACE/build/stonking/
