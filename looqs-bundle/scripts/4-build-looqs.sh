#!/bin/bash

set -e

SELF=$(readlink -f "$0")
HERE=${SELF%/*}
OUT="${HERE}/out/../"

rm -rf "${OUT}"
mkdir "${OUT}"
mkdir "${OUT}/lib"
mkdir "${OUT}/bin"
chmod -R 755 "${OUT}"

gpg --keyserver keyserver.ubuntu.com --recv  534E4209AB49EEE1C19D96162C44695DB9F6043D


. ./scripts/CONFIG
wget https://quitesimple.org/share/pubkey
sha256sum pubkey | grep fe5ce4868d6998aabe08ab51dc2d8fded73cf126d03e2df37045b6c486904356
gpg --import pubkey


rm -rf looqs
git clone https://github.com/quitesimpleorg/looqs
cd looqs
git submodule init
git submodule update
git fetch

if [ "$TAG" != "master" -a "$TAG" != "dev" ] ; then
git verify-tag "$TAG"
fi
git checkout "$TAG"

qmake
make

cp cli/looqs  "${OUT}/bin/"
cp gui/looqs-gui "${OUT}/bin/"
cp LICENSE* "${OUT}/"

for lib in $( find /usr/lib64/ -mindepth 1 | grep libQt | grep .so ) ; do
cp -a "$lib" "${OUT}/lib/"
done

cp -a /usr/lib64/libcrypto* "${OUT}/lib/"
cp -a /usr/lib64/qt5/plugins "${OUT}/lib/"

for lib in $( ldd gui/looqs-gui |   awk '{print $3}' | grep so  | grep -vE "libGL|libm.so|libc|harfbuzz|fontconfig|libgcc|freetype|libX11|libQt" ) ; do
cp "$lib" "${OUT}/lib/"
done


chown user -R "${OUT}"