# b.8.39.Inetutils-2.4.sh
#

# (based on Errata use: )
export PKG="inetutils-2.4"
export PKGLOG_DIR=$LFSLOG/8.39
export PKGLOG_TAR=$PKGLOG_DIR/tar.log
export PKGLOG_CONFIG=$PKGLOG_DIR/config.log
export PKGLOG_BUILD=$PKGLOG_DIR/build.log
export PKGLOG_CHECK=$PKGLOG_DIR/check.log
export PKGLOG_INSTALL=$PKGLOG_DIR/install.log
export PKGLOG_ERROR=$PKGLOG_DIR/error.log

mkdir $PKGLOG_DIR

echo "1. Extract tar..."
tar xvf $PKG.tar.xz > $PKGLOG_TAR 2> $PKGLOG_ERROR
cd $PKG

time { \
\
echo "2. Configure ..."     && \
./configure --prefix=/usr           \
            --bindir=/usr/bin       \
            --localstatedir=/var    \
            --disable-logger        \
            --disable-whois         \
            --disable-rcp           \
            --disable-rexec         \
            --disable-rlogin        \
            --disable-rsh           \
            --disable-servers       \
            > $PKGLOG_CONFIG 2>> $PKGLOG_ERROR  && \
\
echo "3. Make Build ..."                && \
make > $PKGLOG_BUILD 2>> $PKGLOG_ERROR  && \
\
echo "4. Make Check ..."                && \
make check > $PKGLOG_CHECK 2>> $PKGLOG_ERROR    && \
\
echo "5. Make Install ..."              && \
make install > $PKGLOG_INSTALL 2>> $PKGLOG_ERROR    && \
\
mv -v /usr/{,s}bin/ifconfig     \
\
; }

cd ..
rm -rf $PKG
unset PKGLOG_ERROR PKGLOG_INSTALL PKGLOG_CHECK
unset PKGLOG_BUILD PKGLOG_CONFIG PKGLOG_TAR
unset PKGLOG_DIR PKG
