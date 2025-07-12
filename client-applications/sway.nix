{ config, pkgs, stylix, ... }: {

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  programs.sway.enable = true;
  # programs.waybar.enable = true;

  fonts.fontconfig.enable = true;

  environment.systemPackages = with pkgs; [ 
    swaybg
    swaylock

    foot

    font-awesome
   ];

   stylix.enable = true;
   stylix.autoEnable = true;
   stylix.polarity = "dark";
   stylix.cursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
   };

  stylix.image = ./kirsch.png;

  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.jetbrains-mono;
      name = "Jetbrains Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
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
}