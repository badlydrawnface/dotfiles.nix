{ pkgs ? import <nixpkgs> { } }: {
  mudita-center = pkgs.callPackage ./mudita-center { };
}
