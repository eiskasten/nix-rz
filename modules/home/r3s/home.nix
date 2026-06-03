{ self, inputs, ... }:
{

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.r3s = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.r3sModule
      {
        home.username = "r3s";
        home.homeDirectory = "/home/r3s";
      }
    ];
  };

  flake.homeModules.r3sModule =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.xdg
        self.homeModules.dev
        self.homeModules.gpg
        self.homeModules.firefox
        self.homeModules.multimedia

        self.homeModules.sway
        self.homeModules.waybar
        self.homeModules.kanshi
        self.homeModules.rofi
        self.homeModules.mako

        self.homeModules.pass

        self.homeModules.r3sDev
        self.homeModules.r3sSSH
        self.homeModules.r3sMail

      ];
      home.stateVersion = "26.05";
    };
}
