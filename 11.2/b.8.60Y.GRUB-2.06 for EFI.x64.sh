# b.8.60Y.GRUB-2.06 for EFI.x64.sh
#

export PKG="grub-2.06"
export PKGLOG_DIR=$LFSLOG/8.60Y
export PKGLOG_TAR=$PKGLOG_DIR/tar.log
export PKGLOG_CONFIG=$PKGLOG_DIR/config.log
export PKGLOG_BUILD=$PKGLOG_DIR/build.log
#export PKGLOG_CHECK=$PKGLOG_DIR/check.log
export PKGLOG_INSTALL=$PKGLOG_DIR/install.log
export PKGLOG_ERROR=$PKGLOG_DIR/error.log

mkdir $PKGLOG_DIR

echo "1. Extract tar..."
tar xvf $PKG.tar.xz > $PKGLOG_TAR 2> $PKGLOG_ERROR
cd $PKG

mkdir -pv /usr/share/fonts/unifont
gunzip -c ../unifont-14.0.04.pcf.gz       \
  > /usr/share/fonts/unifont/unifont.pcf  \
  2>> $PKGLOG_ERROR

time { \
\
echo "2. Configure ..."           && \
./configure --prefix=/usr         \
            --sysconfdir=/etc     \
            --disable-efiemu      \
            --enable-grub-mkfont  \
            --with-platform=efi   \
            --target=x86_64       \
            --disable-werror      \
            > $PKGLOG_CONFIG 2>> $PKGLOG_ERROR         && \
\
echo "3. Make Build ..."                  && \
make > $PKGLOG_BUILD 2>> $PKGLOG_ERROR    && \
\
echo "4. Make Install ..."                && \
make install                              \
     > $PKGLOG_INSTALL 2>> $PKGLOG_ERROR  && \
\
mv -v /etc/bash_completion.d/grub \
  /usr/share/bash-completion/completions  \
\
; }


cd ..
rm -rf $PKG
#unset PKGLOG_CHECK
unset PKGLOG_INSTALL PKGLOG_BUILD PKGLOG_CONFIG
unset PKGLOG_ERROR PKGLOG_TAR
unset PKGLOG_DIR PKG
