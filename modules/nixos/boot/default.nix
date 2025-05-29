{ config, lib, pkgs, ... }: {
  imports = [
    ./plymouth
    ./lanzaboote
  ];
}