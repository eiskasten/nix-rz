{ self, inputs, ... }:
{
  flake.nixosModules.fucikConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.fucikHardware
        # add features here

        self.nixosModules.dev
        self.nixosModules.shell
        self.nixosModules.mail
        self.nixosModules.multimedia
        self.nixosModules.office
        self.nixosModules.security
        self.nixosModules.sway
        self.nixosModules.users
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
}
