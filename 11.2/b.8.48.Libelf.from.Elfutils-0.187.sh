# b.8.48.Libelf.from.Elfutils-0.187.sh
#

export PKG="elfutils-0.187"
export PKGLOG_DIR=$LFSLOG/8.48
export PKGLOG_TAR=$PKGLOG_DIR/tar.log
export PKGLOG_CONFIG=$PKGLOG_DIR/config.log
export PKGLOG_BUILD=$PKGLOG_DIR/build.log
export PKGLOG_CHECK=$PKGLOG_DIR/check.log
export PKGLOG_INSTALL=$PKGLOG_DIR/install.log
export PKGLOG_ERROR=$PKGLOG_DIR/error.log

mkdir $PKGLOG_DIR

echo "1. Extract tar..."
tar xvf $PKG.tar.bz2 > $PKGLOG_TAR 2> $PKGLOG_ERROR
cd $PKG

time { \
\
echo "2. Configure ..."                 && \
./configure --prefix=/usr                    \
            --disable-debuginfod             \
            --enable-libdebuginfod=dummy     \
            > $PKGLOG_CONFIG 2>> $PKGLOG_ERROR  && \
\
echo "3. Make Build ..."                && \
make > $PKGLOG_BUILD 2>> $PKGLOG_ERROR  && \
\
echo "4. Make Check ..."                && \
make check                              \
     > $PKGLOG_CHECK 2>> $PKGLOG_ERROR  && \
\
echo "5. Make Install ..."              && \
make -C libelf install                  \
     > $PKGLOG_INSTALL 2>> $PKGLOG_ERROR               && \
install -vm644 config/libelf.pc /usr/lib/pkgconfig     && \
rm /usr/lib/libelf.a                                   \
\
; }

cd ..
rm -rf $PKG
unset PKGLOG_CHECK
unset PKGLOG_INSTALL PKGLOG_BUILD PKGLOG_CONFIG
unset PKGLOG_ERROR PKGLOG_TAR
unset PKGLOG_DIR PKG
