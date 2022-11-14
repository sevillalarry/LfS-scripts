# b.8.52.Ninja-1.11.0.sh
#

export PKG="ninja-1.11.0"
export PKGLOG_DIR=$LFSLOG/8.52
export PKGLOG_TAR=$PKGLOG_DIR/tar.log
#export PKGLOG_CONFIG=$PKGLOG_DIR/config.log
export PKGLOG_BUILD=$PKGLOG_DIR/build.log
export PKGLOG_CHECK=$PKGLOG_DIR/check.log
export PKGLOG_INSTALL=$PKGLOG_DIR/install.log
export PKGLOG_ERROR=$PKGLOG_DIR/error.log

mkdir $PKGLOG_DIR

echo "1. Extract tar..."
tar xvf $PKG.tar.gz > $PKGLOG_TAR 2> $PKGLOG_ERROR
cd $PKG

export NINJAJOBS=4

sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc

time { \
\
echo "2. Build ..."      && \
python3 configure.py --bootstrap    \
    > $PKGLOG_BUILD 2>> $PKGLOG_ERROR   && \
\
echo "3. Test ..."  && \
./ninja ninja_test  \
     > $PKGLOG_CHECK 2>> $PKGLOG_ERROR              && \
./ninja_test --gtest_filter=-SubprocessTest.SetWithLots \
    >> $PKGLOG_CHECK 2>> $PKGLOG_ERROR              && \
\
echo "4. Install ..."                               && \
install -vm755 ninja /usr/bin/                      \
     > $PKGLOG_INSTALL 2>> $PKGLOG_ERROR            && \
install -vDm644 misc/bash-completion                \
    /usr/share/bash-completion/completions/ninja    \
    >> $PKGLOG_INSTALL 2>> $PKGLOG_ERROR            && \
install -vDm644 misc/zsh-completion                 \
    /usr/share/zsh/site-functions/_ninja            \
    >> $PKGLOG_INSTALL 2>> $PKGLOG_ERROR            \
\
; }

cd ..
rm -rf $PKG
unset PKGLOG_CHECK
unset PKGLOG_INSTALL PKGLOG_BUILD
# PKGLOG_CONFIG
unset PKGLOG_ERROR PKGLOG_TAR
unset PKGLOG_DIR PKG
