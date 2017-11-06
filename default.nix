let
  pkgs = import <nixpkgs> {}; 
  autoreconf = pkgs.autoreconf;
  stdenv = pkgs.stdenv;
  fetchurl = pkgs.fetchUrl;
  pkgconfig = pkgs.pkgsconfig;
  autoreconfHook = pkgs.autoreconfHook;
  openssl = pkgs.openssl;
  c-db48 = pkgs.db48; #.overrideAttrs { };
    #configureFlags = pkgs.db48.configureFlags; # ++ " --disable-shared";
  boost = pkgs.boost155;
  zlib = pkgs.zlib;
  miniupnpc = pkgs.miniupnpc;
  qt4 = pkgs.qt4;
  glibc = pkgs.glibc;
  utillinux = pkgs.utillinux;
  protobuf = pkgs.protobuf;
  qrencode = pkgs.qrencode;
  libevent = pkgs.libevent;
  withGui = pkgs.withGui;
  gcc = if stdenv.cc.isGNU then stdenv.cc.cc else stdenv.cc.cc.gcc;
in rec {
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
      openssl c-db48 boost zlib miniupnpc protobuf libevent
      utillinux qt4 qrencode
    ];
  };
}
