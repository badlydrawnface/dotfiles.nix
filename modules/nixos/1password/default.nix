{ pkgs, lib, config, ... }: {

  options = {
    _1password.enable = lib.mkEnableOption "Enable 1Password and Integrations";
  };

  config = lib.mkIf config._1password.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "bdface" ];
    };

    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
	  .zen
	'';
	mode = "0755";
      };
    };
  };
}
