{ self, inputs, ... }:
{
  flake.homeModules.firefox =
    { pkgs, ... }:
    {
      stylix.targets.firefox.profileNames = [ "default" ];
      programs.firefox = {
        enable = true;
        profiles.default = {
          extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
            ublock-origin
            browserpass
          ];
          settings = {
            extensions.autoDisableScopes = 0;
          };
        };
      };
    };
}
