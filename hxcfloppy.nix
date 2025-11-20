{
  stdenv,
  fetchFromGitHub,
  fetchurl,
  pkg-config,
  autoconf,
  automake,
  wayland,
  wayland-scanner,
  libxkbcommon,
  # xorg,
  ## fltk deps
  lib,
  zlib,
  libjpeg,
  libpng,
  fontconfig,
  freetype,
  libX11,
  libXext,
  libXinerama,
  libXfixes,
  libXcursor,
  libXft,
  wayland-protocols,
  libXrender,

  withGL ? true,
  libGL,
  libGLU,
  glew,

  withCairo ? true,
  cairo,

  pango,

  doxygen,
  graphviz,

  withExamples ? (stdenv.buildPlatform == stdenv.hostPlatform),
  withShared ? true,
}:
let
  thirdPartySrc = fetchurl {
    url = "https://github.com/fltk/fltk/releases/download/release-1.4.2/fltk-1.4.2-source.tar.gz";
    sha256 = "sha256-q/UcZcc+CNRwSIs/yDTJQ9yM7Bb3kZFlgn80AzGKFe8=";
  };
in
stdenv.mkDerivation {
  pname = "hxcfloppy";
  version = "2023-10-30";
  src = fetchFromGitHub {
    owner = "jfdelnero";
    repo = "HxCFloppyEmulator";
    rev = "HxCFloppyEmulator_V2_16_13_1";
    sha256 = "sha256-ZuluAI3dH8OyBZnn3ywgOhVGWxKhsb6V7BFSxWlVigY=";
  };
  buildInputs = [
    autoconf
    automake
    pkg-config
    libxkbcommon
    wayland
    wayland-scanner
    wayland-protocols
    # xorg.libX11
    # xorg.libXft
  ]
  #the rest are fltk
  ++ lib.optionals (withGL && !stdenv.hostPlatform.isDarwin) [
    libGL
    libGLU
  ]
  ++ lib.optionals (withExamples && withGL) [
    glew
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    fontconfig
  ];

  propagatedBuildInputs = [
    # all fltk
    zlib
    libjpeg
    libpng
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    freetype
    libX11
    libXext
    libXinerama
    libXfixes
    libXcursor
    libXft
    libXrender
    cairo
    pango
  ];
  postPatch = ''
    substituteInPlace HxCFloppyEmulator_software/sources/thirdpartylibs/fltk/prepare_fltk.sh \
       --replace-fail 'wget $DOWNLOADURL -nc || exit 1' \
       "cp ${thirdPartySrc} fltk-1.4.2-source.tar.gz"
  '';
  preConfigure = "cd build";

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    cp ./hxcfloppyemulator $out/bin
    cp ./hxcfe $out/bin
    cp ./*.so $out/lib
  '';
}
