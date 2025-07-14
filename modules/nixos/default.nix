{ ... }:
{
  imports = [
    ./boot
    ./flatpak.nix
    ./fprintd.nix
    ./greetd.nix
    ./hyprland.nix
    ./pipewire.nix
    ./sddm.nix
    ./security.nix
  ];
}
