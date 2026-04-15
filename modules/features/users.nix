{ self, inputs, ... }:
{
  flake.nixosModules.users =
    { config, pkgs, ... }:

    {
      security.pam.enableFscrypt = true;

      users.users.r3s = {
        name = "r3s";
        createHome = true;
        description = "Richard Stöckl";
        isNormalUser = true;
        initialPassword = "123456";
        extraGroups = [ "wheel" ];
      };

      home-manager.users.r3s = self.homeModules.r3sModule;
    };
}
