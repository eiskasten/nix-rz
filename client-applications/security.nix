{ config, pkgs, ... }: {

  security = {
    doas = {
      enable = true;

    };
  };

    programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.polkit.enable = true;
}