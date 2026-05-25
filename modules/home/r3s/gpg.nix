{ ... }:
{
  flake.homeModules.r3sGPG =
    { pkgs, ... }:
    {
      services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
        enableZshIntegration = true;
        pinentry.package = pkgs.pinentry-rofi;
        pinentry.program = "pinentry-rofi";
      };
    };
}
