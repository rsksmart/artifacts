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

mkdir -p $WORKSPACE/source/{zesty,xenial,trusty,artful}/rskj_$VERSION

cp -r ~/artifacts/rskj-ubuntu-installer/rskj_package_zesty/. $WORKSPACE/source/zesty/rskj_$VERSION/
cp -r ~/artifacts/rskj-ubuntu-installer/rskj_package_xenial/. $WORKSPACE/source/xenial/rskj_$VERSION/
cp -r ~/artifacts/rskj-ubuntu-installer/rskj_package_trusty/. $WORKSPACE/source/trusty/rskj_$VERSION/
cp -r ~/artifacts/rskj-ubuntu-installer/rskj_package_artful/. $WORKSPACE/source/artful/rskj_$VERSION/

sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/zesty/rskj_$VERSION/debian/control
sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/zesty/rskj_$VERSION/debian/changelog
sed -i "s|<DATE>|${RFCDATE}|g" $WORKSPACE/source/zesty/rskj_$VERSION/debian/changelog

sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/artful/rskj_$VERSION/debian/control
sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/artful/rskj_$VERSION/debian/changelog
sed -i "s|<DATE>|${RFCDATE}|g" $WORKSPACE/source/artful/rskj_$VERSION/debian/changelog

sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/trusty/rskj_$VERSION/debian/control
sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/trusty/rskj_$VERSION/debian/changelog
sed -i "s|<DATE>|${RFCDATE}|g" $WORKSPACE/source/trusty/rskj_$VERSION/debian/changelog

sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/xenial/rskj_$VERSION/debian/control
sed -i "s|<V>|${VERSION}|g" $WORKSPACE/source/xenial/rskj_$VERSION/debian/changelog
sed -i "s|<DATE>|${RFCDATE}|g" $WORKSPACE/source/xenial/rskj_$VERSION/debian/changelog

cp $FILE_NAME_NODE $WORKSPACE/source/zesty/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/xenial/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/trusty/rskj_$VERSION/src/rsk.jar
cp $FILE_NAME_NODE $WORKSPACE/source/artful/rskj_$VERSION/src/rsk.jar

cp ~/artifacts/rskj-ubuntu-installer/config/regtest.conf $WORKSPACE/source/zesty/rskj_$VERSION/src/regtest.conf
cp ~/artifacts/rskj-ubuntu-installer/config/mainnet.conf $WORKSPACE/source/zesty/rskj_$VERSION/src/mainnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/testnet.conf $WORKSPACE/source/zesty/rskj_$VERSION/src/testnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/logback.xml $WORKSPACE/source/zesty/rskj_$VERSION/src/
cp ~/artifacts/rskj-ubuntu-installer/init-scripts/rsk.service-node $WORKSPACE/source/zesty/rskj_$VERSION/src/rsk.service

cp ~/artifacts/rskj-ubuntu-installer/config/regtest.conf $WORKSPACE/source/artful/rskj_$VERSION/src/regtest.conf
cp ~/artifacts/rskj-ubuntu-installer/config/mainnet.conf $WORKSPACE/source/artful/rskj_$VERSION/src/mainnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/testnet.conf $WORKSPACE/source/artful/rskj_$VERSION/src/testnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/logback.xml $WORKSPACE/source/artful/rskj_$VERSION/src/
cp ~/artifacts/rskj-ubuntu-installer/init-scripts/rsk.service-node $WORKSPACE/source/artful/rskj_$VERSION/src/rsk.service

cp ~/artifacts/rskj-ubuntu-installer/config/testnet.conf $WORKSPACE/source/xenial/rskj_$VERSION/src/testnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/regtest.conf $WORKSPACE/source/xenial/rskj_$VERSION/src/regtest.conf
cp ~/artifacts/rskj-ubuntu-installer/config/mainnet.conf $WORKSPACE/source/xenial/rskj_$VERSION/src/mainnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/logback.xml $WORKSPACE/source/xenial/rskj_$VERSION/src/
cp ~/artifacts/rskj-ubuntu-installer/init-scripts/rsk.service-node $WORKSPACE/source/xenial/rskj_$VERSION/src/rsk.service

cp ~/artifacts/rskj-ubuntu-installer/config/regtest.conf $WORKSPACE/source/trusty/rskj_$VERSION/src/regtest.conf
cp ~/artifacts/rskj-ubuntu-installer/config/mainnet.conf $WORKSPACE/source/trusty/rskj_$VERSION/src/mainnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/testnet.conf $WORKSPACE/source/trusty/rskj_$VERSION/src/testnet.conf
cp ~/artifacts/rskj-ubuntu-installer/config/logback.xml $WORKSPACE/source/trusty/rskj_$VERSION/src/
cp ~/artifacts/rskj-ubuntu-installer/init-scripts/rsk-node $WORKSPACE/source/trusty/rskj_$VERSION/src/rsk

echo "####################################################"
echo "#                   BUILD ZESTY                    #"
echo "####################################################"
cd $WORKSPACE/source/zesty/rskj_$VERSION
debuild -us -uc -S

echo "####################################################"
echo "#                   BUILD ARTFUL                   #"
echo "####################################################"
cd $WORKSPACE/source/artful/rskj_$VERSION
debuild -us -uc -S

echo "####################################################"
echo "#                   BUILD XENIAL                   #"
echo "####################################################"
cd $WORKSPACE/source/xenial/rskj_$VERSION
debuild -us -uc -S

echo "####################################################"
echo "#                   BUILD TRUSTY                   #"
echo "####################################################"
cd $WORKSPACE/source/trusty/rskj_$VERSION
debuild -us -uc -S
cd $WORKSPACE/source/xenial

mkdir -p $WORKSPACE/build/{xenial,trusty,zesty,artful}

mv $WORKSPACE/source/trusty/rskj_$VERSION* $WORKSPACE/build/trusty/
mv $WORKSPACE/source/xenial/rskj_$VERSION* $WORKSPACE/build/xenial/
mv $WORKSPACE/source/zesty/rskj_$VERSION* $WORKSPACE/build/zesty/
mv $WORKSPACE/source/artful/rskj_$VERSION* $WORKSPACE/build/artful/
