# NixOS Config (very much a WIP)

I have been learning how to use Nix as of late, and I was just trying to configure things to my liking across different devices.

## How to enable TPM FDE
```
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+7+12 --wipe-slot=tpm2 /dev/nvme0nXpX
```

Replace nvme0nXpX with the encrypted partition(s) you want to use.
This is only going to work with both Lanzaboote and the initrd to be setup on a LUKS-encrypted drive.


## Modularization goals
- [X] Get Catppuccin working properly
- [ ] Extract binary cache/nix settings
- [ ] maybe make package modules
- [X] color adw-gtk3 so i am not dependent on the ~~deprecated~~ now removed `catppuccin.gtk`

**TODO**
