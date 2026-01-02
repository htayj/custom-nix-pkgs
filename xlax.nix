{
  stdenv,
  fetchurl,
  xorg,
  libXpm,
  libXext,
}:
stdenv.mkDerivation {
  pname = "xlax";
  version = "rev7f3e44df2e8b72a18e3d4c8df8fe589d6e6c1ab7";
  src = fetchurl {
    url = "https://hea-www.harvard.edu/~fine/Tech/xlax2.4.tar.gz";
    hash = "sha256-quklN50VzOxvqfgrFAltFGE8nTQoIOUVqmEFK76a0tw=";
  };
  # unpackPhase = ''
  #   tar xzf xlax2.4.tar.gz

  # '';
  setSourceRoot = "sourceRoot=$(echo ./xlax2.4)";
  buildInputs = [
  ];
  nativeBuildInputs = [
    xorg.imake
    xorg.libXt
    xorg.libXaw
    libXpm
    libXext
  ];
  configurePhase = ''
    xmkmf
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./xlax $out/bin
  '';
}
