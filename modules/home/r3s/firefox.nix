{ self, inputs, ... }:
{
  imports = [
    inputs.flakeModules.firefox-addons.module
  ];
  flake.homeModules.r3sFirefox =
    { firefox-addons, pkgs, ... }:
    {
      programs.firefox = {
        enable = true;
        profiles.default = {
          extensions.packages = with firefox-addons.packages.${pkgs.system}; [ ublock-origin ];
          settings = {
            extensions.autoDisableScopes = 0;
          };
        };
      };
    };
}
