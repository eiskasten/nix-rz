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
    {
      pkgs,
      config,
      osConfig ? null,
      ...
    }:
    {
      imports = [
        self.homeModules.xdg
        self.homeModules.dev
        self.homeModules.ssh
        self.homeModules.gpg
        self.homeModules.firefox
        self.homeModules.multimedia
        self.homeModules.office

        self.homeModules.sway
        self.homeModules.waybar
        self.homeModules.kanshi
        self.homeModules.rofi
        self.homeModules.mako

        self.homeModules.pass
        self.homeModules.sops

        self.homeModules.r3sDev
        self.homeModules.r3sSSH
        self.homeModules.r3sMail
        self.homeModules.r3sCommunication

      ];
      my.kanshi.internalMonitor = {
        criteria = "BOE 0x07DB Unknown";
        mode = "1920x1080@60";
        scale = 1.0;

        logical = {
          width = 1920;
          height = 1080;
        };
      };
      home.stateVersion = "26.05";
    };
}
