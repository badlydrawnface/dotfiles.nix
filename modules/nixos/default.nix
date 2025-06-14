{ config, lib, pkgs, ... }: {
  imports = [
    ./1password
    ./boot
    ./desktops
    ./flatpak
    ./fprintd
    ./greetd
    ./pipewire
    ./qt
    ./sddm
    ./security
    ./xdg
  ];
}
