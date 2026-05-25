{ ... }:
{
  flake.homeModules.r3sXDG =
    { config, ... }:
    let
      base = config.home.homeDirectory;
    in
    {
      xdg.userDirs = {
        enable = true;

        desktop = "${base}/desk";
        documents = "${base}/doc";
        download = "${base}/downloads";
        music = "${base}/music";
        pictures = "${base}/pic";
        videos = "${base}videos";
        projects = "${base}/src";

      };
    };
}
