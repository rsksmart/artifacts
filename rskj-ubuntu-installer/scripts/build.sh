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
HOME=$(eval echo "~$USER")

WORKSPACE=$(echo "$HOME/$VERSION")
mkdir -p $WORKSPACE/source

mkdir -p $WORKSPACE/source/{bionic,jammy,focal,noble}/rskj_$VERSION

cp -r ~/artifacts/rskj-ubuntu-installer/rskj_package_focal/. $WORKSPACE/source/focal/rskj_$VERSION/
cp -r ~/artifacts/rskj-ubuntu-installer/rskj_package_bionic/. $WORKSPACE/source/bionic/rskj_$VERSION/
cp -r ~/artifacts/rskj-ubuntu-installer/rskj_package_jammy/. $WORKSPACE/source/jammy/rskj_$VERSION/
cp -r ~/artifacts/rskj-ubuntu-installer/rskj_package_noble/. $WORKSPACE/source/noble/rskj_$VERSION/

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

cp $FILE_NAME_NODE $WORKSPACE/source/focal/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/bionic/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/jammy/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/noble/rskj_$VERSION/src/rsk.jar

cp ~/artifacts/rskj-ubuntu-installer/config/regtest.conf $WORKSPACE/source/focal/rskj_$VERSION/src/regtest.conf
cp ~/artifacts/rskj-ubuntu-installer/config/mainnet.conf $WORKSPACE/source/focal/rskj_$VERSION/src/mainnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/testnet.conf $WORKSPACE/source/focal/rskj_$VERSION/src/testnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/logback.xml $WORKSPACE/source/focal/rskj_$VERSION/src/
cp ~/artifacts/rskj-ubuntu-installer/init-scripts/rsk.service-node $WORKSPACE/source/focal/rskj_$VERSION/src/rsk.service

cp ~/artifacts/rskj-ubuntu-installer/config/regtest.conf $WORKSPACE/source/bionic/rskj_$VERSION/src/regtest.conf
cp ~/artifacts/rskj-ubuntu-installer/config/mainnet.conf $WORKSPACE/source/bionic/rskj_$VERSION/src/mainnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/testnet.conf $WORKSPACE/source/bionic/rskj_$VERSION/src/testnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/logback.xml $WORKSPACE/source/bionic/rskj_$VERSION/src/
cp ~/artifacts/rskj-ubuntu-installer/init-scripts/rsk.service-node $WORKSPACE/source/bionic/rskj_$VERSION/src/rsk.service

cp ~/artifacts/rskj-ubuntu-installer/config/regtest.conf $WORKSPACE/source/jammy/rskj_$VERSION/src/regtest.conf
cp ~/artifacts/rskj-ubuntu-installer/config/mainnet.conf $WORKSPACE/source/jammy/rskj_$VERSION/src/mainnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/testnet.conf $WORKSPACE/source/jammy/rskj_$VERSION/src/testnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/logback.xml $WORKSPACE/source/jammy/rskj_$VERSION/src/
cp ~/artifacts/rskj-ubuntu-installer/init-scripts/rsk.service-node $WORKSPACE/source/jammy/rskj_$VERSION/src/rsk.service

cp ~/artifacts/rskj-ubuntu-installer/config/regtest.conf $WORKSPACE/source/noble/rskj_$VERSION/src/regtest.conf
cp ~/artifacts/rskj-ubuntu-installer/config/mainnet.conf $WORKSPACE/source/noble/rskj_$VERSION/src/mainnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/testnet.conf $WORKSPACE/source/noble/rskj_$VERSION/src/testnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/logback.xml $WORKSPACE/source/noble/rskj_$VERSION/src/
cp ~/artifacts/rskj-ubuntu-installer/init-scripts/rsk.service-node $WORKSPACE/source/noble/rskj_$VERSION/src/rsk.service

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

mkdir -p $WORKSPACE/build/{bionic,jammy,focal,noble}

mv $WORKSPACE/source/bionic/rskj_$VERSION* $WORKSPACE/build/bionic/
mv $WORKSPACE/source/jammy/rskj_$VERSION* $WORKSPACE/build/jammy/
mv $WORKSPACE/source/focal/rskj_$VERSION* $WORKSPACE/build/focal/
mv $WORKSPACE/source/noble/rskj_$VERSION* $WORKSPACE/build/noble/
