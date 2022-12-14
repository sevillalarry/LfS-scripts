# b.6.05.Coreutils-9.1.sh
#

export PKG="coreutils-9.1"
export PKGLOG_DIR=$LFSLOG/6.05
export PKGLOG_TAR=$PKGLOG_DIR/tar.log
export PKGLOG_CONFIG=$PKGLOG_DIR/config.log
export PKGLOG_BUILD=$PKGLOG_DIR/build.log
export PKGLOG_INSTALL=$PKGLOG_DIR/install.log
export PKGLOG_ERROR=$PKGLOG_DIR/error.log

mkdir $PKGLOG_DIR

echo "1. Extract tar..."
tar xvf $PKG.tar.xz > $PKGLOG_TAR 2> $PKGLOG_ERROR
cd $PKG

time { \
\
echo "2. Configure ..."     && \
./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --enable-install-program=hostname \
            --enable-no-install-program=kill,uptime \
            > $PKGLOG_CONFIG 2>> $PKGLOG_ERROR  && \
\
echo "3. Make Build ..."                        && \
make > $PKGLOG_BUILD 2>> $PKGLOG_ERROR          && \
\
echo "4. Make Install ..."                      && \
make DESTDIR=$LFS install   \
    > $PKGLOG_INSTALL 2>> $PKGLOG_ERROR         && \
\
mv -v $LFS/usr/bin/chroot              $LFS/usr/sbin                    && \
mkdir -pv $LFS/usr/share/man/man8                                       && \
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8 && \
sed -i 's/"1"/"8"/'                    $LFS/usr/share/man/man8/chroot.8    \
\
; }

cd ..
rm -rf $PKG
unset PKGLOG_INSTALL PKGLOG_BUILD PKGLOG_CONFIG
unset PKGLOG_ERROR PKGLOG_TAR
unset PKGLOG_DIR PKG
