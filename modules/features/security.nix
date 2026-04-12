{ self, inputs, ... }:
{
  flake.nixosModules.security =
    { pkgs, lib, ... }:
    {

      security = {
        doas = {
          enable = true;
        };
        sudo = {
          enable = false;
        };
      };

      programs.mtr.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      security.polkit.enable = true;
    };
}
