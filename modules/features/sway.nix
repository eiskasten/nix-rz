{ self, inputs, ... }:
{
  flake.nixosModules.sway =
    {
      pkgs,
      lib,
      stylix,
      ...
    }:
    {

      services.xserver.enable = true;
      services.xserver.displayManager.lightdm.enable = true;
      programs.sway.enable = true;
      programs.waybar.enable = true;

      fonts.fontconfig.enable = true;

      services.xserver.xkb.extraLayouts.kdf = {
        symbolsFile = ./kdf;
        description = "Austria (Kempfendorf)";
        languages = [
          "ger"
          "deu"
          "gsw"
          "ces"
          "csz"
          "slo"
          "slk"
        ];
      };

      services.xserver.xkb.layout = "kdf";
      services.xserver.xkb.options = "srvrkeys:none";

      environment.systemPackages = with pkgs; [
        swaybg
        swaylock

        foot

        font-awesome

        grim # screenshot functionality
        slurp # screenshot functionality
        wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
        mako # notification system developed by swaywm maintainer
      ];

      stylix.enable = true;
      stylix.autoEnable = true;
      stylix.polarity = "dark";
      stylix.base16Scheme = ./synthwave-neon.yml;
      stylix.cursor = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 24;
      };

      stylix.image = ./kirsch.png;

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

      # home-manager.users.richi = {
      # imports = [ stylix.homeManagerModules.stylix ];
      # } ;
      # home-manager.sharedModules = [
      #   {
      #     stylix.targets.sway.enable = true;
      #     stylix.targets.foot.enable = true;
      #   }
      # ];
    };
}
