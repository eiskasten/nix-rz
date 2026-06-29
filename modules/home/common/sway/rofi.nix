{ ... }:
{
  flake.homeModules.rofi =
    { pkgs, lib, ... }:
    {
      programs.rofi = {
        enable = true;
        pass.enable = true;

        plugins = [
        ];

        modes = [
          "drun"
          "run"
          "combi"
          "window"
          "keys"

          "ssh"

          "filebrowser"
        ];
      };
    };
}
