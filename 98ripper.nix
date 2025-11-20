{
  stdenv,
  fetchFromGitLab,
}:
stdenv.mkDerivation {
  pname = "98ripper";
  src = fetchFromGitLab {
    owner = "bunnylin";
    repo = "98ripper";
    rev = "7f3e44df2e8b72a18e3d4c8df8fe589d6e6c1ab7";
    sha256 = "sha256-OVTaaWlndqK1o7vi7iDI4QWn7JNob7enRxiFGDg+u5Y=";
  };
  buildInputs = [
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./98ripper $out/bin
  '';
}
