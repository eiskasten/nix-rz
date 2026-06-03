{ ... }:
{
  flake.homeModules.office =
    { config, pkgs, ... }:
    let
      base = config.home.homeDirectory;
    in
    {
      home.packages = [
        pkgs.zathura

        pkgs.asciidoctor-with-extensions
        pkgs.libreoffice-fresh
        pkgs.typst
      ];

      programs.texlive.enable = true;
    };
}
