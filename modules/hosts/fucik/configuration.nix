{ self, inputs, ... }:
{
  flake.nixosModules.fucikConfiguration =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      r3sHomeAgeKey = "/var/lib/sops-nix/keys/r3s-home.txt";
    in
    {
      imports = [
        self.nixosModules.fucikHardware
        self.nixosModules.fucikDisko
        # add features here

        self.nixosModules.myHomeManagerModule

        inputs.sops-nix.nixosModules.sops

        self.nixosModules.devModule
        self.nixosModules.nvModule
        self.nixosModules.shellModule
        self.nixosModules.mailModule
        self.nixosModules.multimediaModule
        self.nixosModules.networkModule
        self.nixosModules.brucknerModule
        self.nixosModules.printModule
        self.nixosModules.audioWorkstationModule
        self.nixosModules.securityModule
        self.nixosModules.sopsModule
        self.nixosModules.nfcModule
        self.nixosModules.localeModule
        inputs.stylix.nixosModules.stylix

        self.nixosModules.swayModule
        self.nixosModules.usersModule
      ];

      home-manager.users.r3s = {
        rz.sops.keyFile = r3sHomeAgeKey;
      };

      networking.hostName = "fucik";

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      system.stateVersion = "26.11";
    };
}
