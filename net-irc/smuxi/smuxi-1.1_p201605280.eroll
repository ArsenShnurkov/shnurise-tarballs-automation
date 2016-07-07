WORKDIR=/var/tmp/tarballs/dotnet/net-irc/smuxi/1.1
DISTDIR=/var/calculate/remote/distfiles
mkdir -p "${WORKDIR}"
git clone https://github.com/meebey/smuxi.git "${WORKDIR}"
cd "${WORKDIR}"
git reset --hard bd5845e37ad44b2eb960487f8fc167654f509a5b
./autogen.sh
make dist
cp "${WORKDIR}/smuxi-1.1.tar.gz" "${DISTDIR}/smuxi-1.1_p201605280.tar.gz"
cd -
