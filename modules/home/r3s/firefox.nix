{ self, inputs, ... }:
{
  # imports = [
  #   inputs.firefox-addons.flakeModules.firefox-addons
  # ];
  flake.homeModules.r3sFirefox =
    { pkgs, ... }:
    {
      stylix.targets.firefox.profileNames = [ "default" ];
      programs.firefox = {
        enable = true;
        profiles.default = {
          extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [ ublock-origin ];
          settings = {
            extensions.autoDisableScopes = 0;
          };
        };
      };
    };
}
