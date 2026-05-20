{ self, inputs, ... }:
{
  flake.nixosModules.multimedia =
    { pkgs, lib, ... }:
    {

      programs = {
        git = {
          enable = true;
          lfs.enable = true;
        };

        neovim = {
          enable = true;
          vimAlias = true;
        };
      };

      environment.systemPackages = with pkgs; [
        vlc

        blender
        gimp3-with-plugins
        # inkscape-with-extensions
      ];

      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };
    };
}
