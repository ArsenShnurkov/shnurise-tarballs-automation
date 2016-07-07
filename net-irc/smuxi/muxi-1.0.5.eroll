WORKDIR=/var/tmp/tarballs/dotnet/net-irc/smuxi/1.0.5
DISTDIR=/var/calculate/remote/distfiles
mkdir -p "${WORKDIR}"
git clone https://github.com/meebey/smuxi.git "${WORKDIR}"
cd "${WORKDIR}"
git reset --hard 946702152d731a79e3ce3e23bded3f3597f5d21e
./autogen.sh
make dist
cp "${WORKDIR}/smuxi-1.0.5.tar.gz" "${DISTDIR}/smuxi-1.0.5.tar.gz"
cd -
