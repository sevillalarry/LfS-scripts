# b.8.29.Sed-4.8.sh
#

export PKG="sed-4.8"
export PKGLOG_DIR=$LFSLOG/8.29
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
echo "2. Configure ..."         && \
./configure --prefix=/usr           \
    > $PKGLOG_CONFIG 2>> $PKGLOG_ERROR          && \
\
echo "3. Make Build ..."                        && \
make       > $PKGLOG_BUILD 2>> $PKGLOG_ERROR    && \
make html >> $PKGLOG_BUILD 2>> $PKGLOG_ERROR    && \
\
echo "4. Test results ..."                      && \
chown -Rv tester .                              && \
su tester -c "PATH=$PATH make check"            \
    > $PKGLOG_CHECK 2>> $PKGLOG_ERROR           && \
\
echo "5. Make Install ..."              && \
make install       > $PKGLOG_INSTALL 2>> $PKGLOG_ERROR  && \
install -d -m755           /usr/share/doc/sed-4.8       && \
install -m644 doc/sed.html /usr/share/doc/sed-4.8       \
\
; }

cd ..
rm -rf $PKG
unset PKGLOG_CHECK
unset PKGLOG_INSTALL PKGLOG_BUILD PKGLOG_CONFIG
unset PKGLOG_ERROR PKGLOG_TAR
unset PKGLOG_DIR PKG
