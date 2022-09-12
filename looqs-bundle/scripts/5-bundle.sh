#!/bin/bash
set -e
. scripts/CONFIG


SELF=$(readlink -f "$0")
HERE=${SELF%/*}
OUT="${HERE}/out/../"

DIRNAME="looqs-${TAG}"
ARCHIVENAME="${DIRNAME}.tar.xz"
rm -rf $DIRNAME*
cp -a "${OUT}" ${DIRNAME}
cp src/looqs-gui ${DIRNAME}
cp src/looqs ${DIRNAME}
#cp src/README ${DIRNAME}
chmod 755 src/looqs-gui
chmod 755 src/looqs

patchelf --set-rpath '$ORIGIN/../lib/' ${DIRNAME}/bin/*
patchelf --set-rpath '$ORIGIN' ${DIRNAME}/lib/*.so*
patchelf --set-rpath '$ORIGIN/../../' $( find "${DIRNAME}/lib/plugins/" | grep so$ )


tar cfpvJ "${DIRNAME}".tar.xz "${DIRNAME}"
gpg --batch --no-tty -b --local-user "$SIGNING_KEY_EMAIL" "$ARCHIVENAME"
