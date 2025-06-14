# NixOS Config (very much a WIP)

I have been learning how to use Nix as of late, and I was just trying to configure things to my liking across different devices.

## How to enable TPM FDE
After getting my new Framework 13, I've been working to get the aptly-named `framework` host implemented with a Secure Boot TPM FDE autodecrypt setup, and with Lanzaboote it is possible to have such an implementation. (I have no idea how to even get into setup mode on an MSI motherboard, so my gaming PC is out of the question for now, I managed to do it on the Framework, however) I binded the TPM to the PCR keys 0, 2, 7, and 12, using this command:

```
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+7+12 --wipe-slot=tpm2 /dev/nvme0nXpX
```

Replace nvme0nXpX with the encrypted partition(s) you want to use.

This is only going to work with both Lanzaboote and the initrd to be setup on a LUKS-encrypted drive.

Updates break things a lot, I could not get COSMIC to change themes consistantly, it would change once, and then stay that way.

SDDM on the other hand, crashes Hyprland whenever I log in, and ly takes 25-30 seconds to log in.

Perhaps TTY login might be for the best, especially since I disabled fprintd from logging me in (both for security and so I can also unlock the keyring).

I need sleep.

also **please replace the hardware-configuration.nix with the file generated in /etc/nixos from install**

building with my `hardware-configuration.nix` file will almost certainly cause problems with the next generation.'

# Edit 6/13/25
Apparently kwallet and kwallet5 are dependencies that are installed on all packages from `kdePackages` and `libsForQt5` respectively, I guess no theming at all...

## Modularization goals
- Get Catppuccin working properly
- Extract binary cache/nix settings
- maybe make package modules
- color adw-gtk3 so i am not dependent on the deprecated `catppuccin.gtk`
- get rid of kwallet somehow
- make brave stop opening webpages when i set my mimetypes to zsen

**TODO**
