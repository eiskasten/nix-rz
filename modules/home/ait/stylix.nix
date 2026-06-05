{ ... }:
{
  flake.homeModules.aitStylix =
    { stylix, pkgs, ... }:
    {
      stylix.enable = true;
      stylix.autoEnable = true;
      stylix.polarity = "dark";
      stylix.base16Scheme = ../../features/synthwave-neon.yml;
      stylix.cursor = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 24;
      };

      stylix.fonts = {
        serif = {
          package = pkgs.ibm-plex;
          name = "IBM Plex Serif";
        };

        sansSerif = {
          package = pkgs.ibm-plex;
          name = "IBM Plex Sans";
        };

        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "Jetbrains Mono Nerd Font";
        };

        emoji = {
          package = pkgs.nerd-fonts.symbols-only;
          name = "Symbols Nerd Font";
        };

      };
    };
}
