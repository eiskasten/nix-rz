{ self, inputs, ... }:
{
  flake.nixosModules.office =
    { pkgs, lib, ... }:
    {

      programs = {
        firefox.enable = true;
      };

      environment.systemPackages = with pkgs; [
        # Flakes clones its dependencies through the git command,
        # so git must be installed first
        git
        vim
        wget

        asciidoctor-with-extensions
        libreoffice-fresh
        texliveFull
        typst

        telegram-desktop
      ];

      services.printing.enable = true;
    };
}
