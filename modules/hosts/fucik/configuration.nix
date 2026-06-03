{ self, inputs, ... }:
let
  shortKeyname = "fucik.txt";
in
{
  flake.nixosModules.fucikConfiguration =
    {
      pkgs,
      lib,
      config,
      ...
    }:
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
        self.nixosModules.officeModule
        self.nixosModules.audioWorkstationModule
        self.nixosModules.securityModule
        self.nixosModules.nfcModule
        self.nixosModules.localeModule
        inputs.stylix.nixosModules.stylix

        self.nixosModules.swayModule
        self.nixosModules.usersModule
      ];

      sops.age.keyFile = "/var/lib/sops-nix/${shortKeyname}";
      sops.age.generateKey = false;
      sops.defaultSopsFile = ../../secrets/net.yaml;

      networking.hostName = "fucik";

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
}
