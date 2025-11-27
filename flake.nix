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
        pc98ripper = callPackage ./pc98ripper.nix { };
        # ffglitch = callPackage ./ffglitch.nix { };
        # fluxengine = callPackage ./fluxengine.nix { }; # latest fails, not sure if it is me or a change to the repo
        fluxengine = callPackage ./fluxengine_upstream.nix { }; # fluxengine package stolen from a PR
      };
    };
}
