{ pkgs ? import <nixpkgs> { } }: {
  openrevolution = pkgs.callPackage ./openrevolution { };
  mudita-center = pkgs.callPackage ./mudita-center { };
}
