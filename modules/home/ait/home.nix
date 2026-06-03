{ self, inputs, ... }:
{

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.ait = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.aitModule
      {
        home.username = "r3s";
        home.homeDirectory = "/home/r3s";
      }
    ];
  };

  flake.homeModules.aitModule =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.xdg
        self.homeModules.dev
        self.homeModules.ssh
        self.homeModules.gpg
        self.homeModules.firefox
        self.homeModules.multimedia

        self.homeModules.sway
        self.homeModules.waybar
        self.homeModules.kanshi
        self.homeModules.rofi
        self.homeModules.mako

        self.homeModules.pass

        self.homeModules.aitStylix
        self.homeModules.aitDev
        self.homeModules.aitSSH
        self.homeModules.aitCommunication
        self.homeModules.aitMenuplan

      ];
      my.kanshi.internalMonitor = {
        criteria = "LG Display 0x06C3 Unknown";
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
