{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    browserPolicies.enable = lib.mkEnableOption "Set Brave system policies (disable some reasons)";
  };

  config = lib.mkIf config.browserPolicies.enable {
    programs.chromium = {
      enable = true;
      extraOpts = {
        "BraveRewardsDisabled" = true;
        "BraveWalletDisabled" = true;
        "BraveAIChatEnabled" = false;
        "TorDisabled" = true;
      };
    };
  };
}
