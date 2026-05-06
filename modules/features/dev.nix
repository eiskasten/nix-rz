{ self, inputs, ... }:
{
  flake.nixosModules.dev =
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
        self.packages.${pkgs.system}.nv

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
