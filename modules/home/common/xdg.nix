{ ... }:
{
  flake.homeModules.xdg =
    { config, pkgs, ... }:
    let
      base = config.home.homeDirectory;
    in
    {
      home.packages = [
        pkgs.zathura
      ];
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

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        };
      };
    };
}
