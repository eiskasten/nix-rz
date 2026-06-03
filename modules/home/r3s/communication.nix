{ ... }:
{
  flake.homeModules.r3sCommunication =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.telegram-desktop
      ];
    };
}
