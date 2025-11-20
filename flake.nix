{
  description = "Custom packages (probably poorly packaged)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    { self, nixpkgs }:
    let
      callPackage = nixpkgs.legacyPackages.x86_64-linux.callPackage;
    in
    {
      packages.x86_64-linux = {
        dectalk = callPackage ./dectalk.nix { };
        hxcfloppy = callPackage ./hxcfloppy.nix { }; # warning: extremely poorly packaged
        pc98ripper = callPackage ./98ripper.nix { };
      };
    };
}
