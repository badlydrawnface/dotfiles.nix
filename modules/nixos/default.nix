{ config, lib, pkgs, ... }: {
  imports = [
    ./1password
    ./boot
    ./flatpak
    ./fprintd
    ./ly
    ./pipewire
    ./sddm
    ./security
    ./xdg
  ];
}
