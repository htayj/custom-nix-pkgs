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
  version = "2023-10-30";
  src = fetchFromGitHub {
    owner = "dectalk";
    repo = "dectalk";
    rev = "c3c1e4ae4117f951d8d7f9ef2848408ec79047fd";
    sha256 = "sha256-CKWHx0jgWD5u1EfWlj6R901A+HvjsYsLg0M/Ny2f3R8=";
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
  setSourceRoot = "sourceRoot=$(echo */.)";
  preConfigure = "cd src && ./autogen.sh";
  preBuild = ''
    mkdir -p ../dist/
  '';

}
