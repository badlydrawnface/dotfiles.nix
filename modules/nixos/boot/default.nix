{ config, lib, pkgs, ... }: {
  imports = [
    ./plymouth
    ./systemd-boot
  ];
}