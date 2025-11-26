{
  stdenv,
  fetchFromGitHub,
  gtk2,
  pulseaudio,
  imlib2,
  autoconf,
  automake,
  git,
  pkg-config,
}:
stdenv.mkDerivation {
  pname = "dectalk";
  version = "git";
  src = fetchFromGitHub {
    owner = "dectalk";
    repo = "dectalk";
    rev = "c3c1e4ae4117f951d8d7f9ef2848408ec79047fd";
    sha256 = "sha256-/Xk/X3j6poNG/13cvPUjda7LJu5BuWMT8/6BUSxcWZo=";
    leaveDotGit = true;
  };
  buildInputs = [
    gtk2
    pulseaudio
    imlib2
    autoconf
    automake
    git
    pkg-config
  ];
  # setSourceRoot = "sourceRoot=$(echo */.)";
  preConfigure = "mkdir dist && cd src && ./autogen.sh";
  # configurePhase = "./configure";

  makeFlags = [ "DESTDIR=$(out)" ];
  installPhase = ''
    mkdir -p $out/bin
    ln $out/say $out/bin
    ln $out/gspeak $out/bin
    ln $out/dtmemory $out/bin
    ln $out/aclock $out/bin
    ln $out/windic $out/bin
  '';
}
