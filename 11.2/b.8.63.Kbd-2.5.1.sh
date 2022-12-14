# b.8.63.Kbd-2.5.1.sh
#

export PKG="kbd-2.5.1"
export PKGLOG_DIR=$LFSLOG/8.63
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
cd source

time { \
\
patch -Np1 -i ../kbd-2.5.1-backspace-1.patch           && \
\
sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure        && \
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in   && \
\
echo "2. Configure ..."            && \
./configure    --prefix=/usr       \
               --disable-vlock     \
               > $PKGLOG_CONFIG 2>> $PKGLOG_ERROR      && \
\
echo "3. Make Build ..."                && \
make > $PKGLOG_BUILD 2>> $PKGLOG_ERROR  && \
\
echo "4. Make Check ..."                && \
make check                              \
     > $PKGLOG_CHECK 2>> $PKGLOG_ERROR  && \
\
echo "5. Make Install ..."              && \
make install                            \
     > $PKGLOG_INSTALL 2>> $PKGLOG_ERROR     && \
\
mkdir -pv           /usr/share/doc/kbd-2.5.1 && \
cp -R -v docs/doc/* /usr/share/doc/kbd-2.5.1 \
\
; }

cd ..
rm -rf $PKG
unset PKGLOG_CHECK
unset PKGLOG_INSTALL PKGLOG_BUILD PKGLOG_CONFIG
unset PKGLOG_ERROR PKGLOG_TAR
unset PKGLOG_DIR PKG
