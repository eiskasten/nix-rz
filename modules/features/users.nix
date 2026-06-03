{ self, inputs, ... }:
{
  flake.nixosModules.usersModule =
    { config, pkgs, ... }:

    {
      security.pam.enableFscrypt = true;

      users.users.r3s = {
        name = "r3s";
        createHome = true;
        description = "Richard Stöckl";
        isNormalUser = true;
        initialHashedPassword = "$y$j9T$6X.bKXXMwFX6VwHVfrJpY1$8nU.HkBON8VWD90.HH83MNniB2qFi1OLBhMRjMG3E.C";
        extraGroups = [
          "audio"
          "wheel"
          "networkmanager"
        ];
      };

      home-manager.users.r3s = self.homeModules.r3sModule;
    };
}
