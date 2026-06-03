{ ... }:
{
  flake.homeModules.aitCommunication =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.mattermost-desktop
        pkgs.teams-for-linux
      ];

    };
}
