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

        self.nixosModules.myHomeManager

        inputs.sops-nix.nixosModules.sops

        self.nixosModules.dev
        self.nixosModules.shell
        self.nixosModules.mail
        self.nixosModules.multimedia
        self.nixosModules.network
        self.nixosModules.brucknerModule
        self.nixosModules.office
        self.nixosModules.audioWorkstationModule
        self.nixosModules.security
        self.nixosModules.localeModule
        inputs.stylix.nixosModules.stylix

        self.nixosModules.sway
        self.nixosModules.users
      ];

      sops.age.keyFile = "/var/lib/sops-nix/${shortKeyname}";
      sops.age.generateKey = false;
      sops.defaultSopsFile = ../../secrets/net.yaml;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
}
