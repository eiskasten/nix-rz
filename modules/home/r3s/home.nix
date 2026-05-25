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
        self.homeModules.r3sXDG
        self.homeModules.r3sDev
        self.homeModules.r3sSSH
        self.homeModules.r3sGPG
        self.homeModules.r3sFirefox
        self.homeModules.r3sMultimedia
        self.homeModules.r3sMail

        self.homeModules.r3sSway
        self.homeModules.r3sWaybar
        self.homeModules.r3sKanshi
        self.homeModules.r3sRofi

        self.homeModules.r3sPass
      ];
      home.stateVersion = "26.05";
    };
}
