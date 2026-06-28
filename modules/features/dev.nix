{ self, inputs, ... }:
{
  flake.nixosModules.devModule =
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

        # sops encryption utilities
        age
        sops
      ];

      virtualisation.podman.enable = true;
      virtualisation.libvirtd = {
        enable = true;
      };
    };
}
