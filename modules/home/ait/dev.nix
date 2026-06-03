{ ... }:
{
  flake.homeModules.aitDev =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.openstackclient-full
        pkgs.uv
      ];

    };
}
