{ config, pkgs, ... }: {

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
  nixpkgs.config.allowUnfree = true; # for intellij
  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git
    vim
    
    curl

    jetbrains.idea-ultimate
    jetbrains.rust-rover
    jetbrains.datagrip

    kubectl
    vscodium

    mfoc-hardnested

    rustup
    openjdk24
  ];

  virtualisation.docker.enable = true;
  virtualisation.libvirtd = {
    enable = true;
  };
}