#!/bin/bash -e
#if [ -d .git ] && [ "$(git status --porcelain | grep -E '^\?\?' | wc -l)" -gt 0 ]; then
#	echo "Clean your repository before!"
#	exit 1
#fi

cd extension
phpize
./configure
make
cd ..
mkdir build.tmp 
cp debian build.tmp/ -r

mkdir -p "build.tmp/usr/lib/php5/20100525/" "build.tmp/usr/share/doc/xhprof/samples"
mkdir -p "build.tmp/etc/php5/conf.d"
cp ./extension/modules/xhprof.so "build.tmp/usr/lib/php5/20100525/"
cp -r examples build.tmp/usr/share/doc/xhprof/samples
cp ./extension/conf.ini /etc/php5/conf.d/xhprof.ini
cd build.tmp
dpkg-buildpackage -uc -tc -rfakeroot -us
cd ..
rm -fr build.tmp

cd extension
phpize  --clean
cd ..

echo "Packaging complete"

