{ self, inputs, ... }:
{
  flake.nixosModules.dev =
    { pkgs, lib, ... }:
    {

      programs = {
        git = {
          enable = true;
          lfs.enable = true;
          config = {
            safe.directory = "/home/r3s/src/nix-rz";
          };
        };

        neovim = {
          enable = true;
          vimAlias = true;
          defaultEditor = true;
        };
      };

      programs.bat.enable = true;

      environment.variables = {
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
        MANGROFOPT = "-c";
      };

      environment.shellAliases = {
        nv = "vim";
      };

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config.allowUnfree = true; # for intellij
      environment.systemPackages = with pkgs; [
        # Flakes clones its dependencies through the git command,
        # so git must be installed first
        git
        vim

        curl

        kubectl
        vscodium

        mfoc-hardnested

        rustup
        openjdk25
      ];

      virtualisation.podman.enable = true;
      virtualisation.libvirtd = {
        enable = true;
      };
    };
}
