# default.nix

let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in
{
  dectalk = pkgs.callPackage ./dectalk.nix { };
  # greaseweazle = pkgs.callPackage ./greaseweazle.nix { };
  hxcfloppy = pkgs.callPackage ./hxcfloppy.nix { };
  pc98ripper = pkgs.callPackage ./98ripper.nix { };
}
