#!/bin/bash

# Update this value to the version of pypy
PYPY_VERSION=5.6
# Where you want to install pypy to
DESTDIR=$HOME/pypy

PYPY_BIN=$DESTDIR/bin/pypy
# The distribution file name of pypy
TARFILE=pypy-${PYPY_VERSION}-linux_x86_64-portable.tar.bz2
# Where portable pypy is available from
SRC=https://bitbucket.org/squeaky/portable-pypy/downloads/$TARFILE

function install_pypy() {
  mkdir --parent $DESTDIR
  cd $DESTDIR
  curl -OL $SRC
  tar jxf $TARFILE --strip-components=1 && rm $TARFILE
}

if [ ! -x ${PYPY_BIN} ]; then
  install_pypy || exit 1
fi

${PYPY_BIN} -m ensurepip
