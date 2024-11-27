{ pkgs, lib, config, ... }: {
  options = {
    systemd-boot.enable = lib.mkEnableOption {
      default = true;
      description = "Enable systemd-boot and enable quiet boot";
    };
  };

  config = lib.mkIf config.systemd-boot.enable {
    boot = {
      loader.systemd-boot.enable = true;
      loader.timeout = 0;

      # Enable "Silent Boot"
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
    };
  };
}