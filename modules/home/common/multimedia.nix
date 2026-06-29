{ ... }:
{
  flake.homeModules.multimedia =
    { pkgs, ... }:
    {
      services.playerctld.enable = true;

      home.packages = with pkgs; [
        vlc
        spotifywm

        blender
        gimp3-with-plugins
        # inkscape
      ];

    };
}
