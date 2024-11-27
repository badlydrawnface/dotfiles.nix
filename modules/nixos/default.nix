{ config, lib, pkgs, ... }: {
  imports = [
    ./ly
    ./boot
    ./sddm
  ];
}