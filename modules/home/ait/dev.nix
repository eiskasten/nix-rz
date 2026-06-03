{ ... }:
{
  flake.homeModules.aitDev =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.openstackclient-full
        pkgs.uv
      ];
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Richard Stöckl";
            email = "richard.stoeckl@ait.ac.at";
          };
        };
      };

    };
}
