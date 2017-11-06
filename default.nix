with import <nixpkgs> {};
let gcc = if stdenv.cc.isGNU then stdenv.cc.cc else stdenv.cc.cc.gcc; in
rec {
  btc = stdenv.mkDerivation rec {
    name = "bitcoin-dev-env";
    src = ./.;
    version = "0.1.0";
    AC_PROG_CXX="$(type -p g++)";
    gppPath = "${gcc}/include/c++/" +
      builtins.replaceStrings ["gcc-"] [""] gcc.name;

    PKG_PROG_PKG_CONFIG="${pkgs.pkgconfig}/bin/pkg-config";
    BDB_CFLAGS="${pkgs.db48}/include";

    BOOST_LIBS="${boost}/lib/";
    BOOST_ROOT="${boost}";

    BOOST_LDFLAGS="-L${boost}/lib/";
    BOOST_CPPFLAGS=
      "-I${boost.dev}/include/ " +
      "-L${boost}/lib/ " +
      "-lboost_system";

    CPPFLAGS =
      "-isystem ${gppPath} " +
      "-isystem ${gppPath}/${stdenv.targetPlatform.config}";

    buildInputs = [
      #pkgs.autogen
      pkgs.autoconf
      pkgs.automake
      pkgs.gnumake
      pkgs.glibc
      pkgs.db48
      #pkgs.leveldb
      pkgs.m4
      #pkgs.libdbi
      pkgs.libtool
      pkgs.pkgconfig
      openssl db48 boost zlib miniupnpc protobuf libevent
      utillinux qt4 qrencode
    ];
  };
}
