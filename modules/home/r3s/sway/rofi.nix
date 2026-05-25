{ ... }:
{
  flake.homeModules.r3sRofi =
    { ... }:
    {
      programs.rofi = {
        enable = true;
        pass.enable = true;
      };
    };
}
