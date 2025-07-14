{
  lib,
  config,
  ...
}:
{
  options = {
    boot.secBoot.enable = lib.mkEnableOption {
      default = true;
      description = "Enable secure boot and enable quiet boot";
    };
  };

  config = lib.mkIf config.boot.secBoot.enable {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      bootspec.enableValidation = true;
      initrd.systemd.enable = true;

      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };

      # # Enable "Silent Boot"
      # consoleLogLevel = 0;
      # initrd.verbose = false;
      # kernelParams = [
      #   "quiet"
      #   "splash"
      #   "boot.shell_on_fail"
      #   "loglevel=3"
      #   "rd.systemd.show_status=false"
      #   "rd.udev.log_level=3"
      #   "udev.log_priority=3"
      # ];
    };
  };
}
