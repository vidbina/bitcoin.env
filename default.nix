with import <nixpkgs> {};
let
  gcc = if stdenv.cc.isGNU then stdenv.cc.cc else stdenv.cc.cc.gcc;
  boost = boost165;
in stdenv.mkDerivation rec {
  name = "bitcoin-dev-env";
  src = ./.;
  version = "0.1.0";
  AC_PROG_CXX="$(type -p g++)";
  gppPath = "${gcc}/include/c++/" +
    builtins.replaceStrings ["gcc-"] [""] gcc.name;

  PKG_PROG_PKG_CONFIG="${pkgs.pkgconfig}/bin/pkg-config";
  BDB_CFLAGS="-I${pkgs.db48.dev}/include";

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
    autoconf
    automake
    boost
    db48
    gcc
    glibc
    gnumake
    libevent
    libtool
    m4
    miniupnpc
    openssl
    pkgconfig
    protobuf
    python3
    qrencode
    qt4
    utillinux
    which
    zlib
  ];

  shellHook = ''
    # https://github.com/NixOS/nix/issues/1056
    export TERMINFO=/run/current-system/sw/share/terminfo
    real_TERM=$TERM; TERM=xterm; TERM=$real_TERM; unset real_TERM

    exitstatus() {
      if [[ $? == 0 ]]; then
        echo -e "\e[92m"
      else
        echo -e "\e[91m"
      fi
    }
    export PS1='\n\[$(exitstatus)\]Ƀ\[\e[39m\] '
    export PS2="\nɃ "
  '';
}
