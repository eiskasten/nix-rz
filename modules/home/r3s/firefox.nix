{ self, inputs, ... }:
{
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
