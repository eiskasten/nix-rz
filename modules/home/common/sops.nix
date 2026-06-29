{ ... }: {
  flake.homeModules.sops =

    {
      config,
      lib,
      pkgs,
      osConfig ? null,
      ...
    }:

    let
      cfg = config.rz.sops;
      isNixOS = osConfig != null;
      secretsDir = ../../secrets;
    in
    {
      options.rz.sops = {
        keyName = lib.mkOption {
          type = lib.types.str;
          default = "${config.home.username}-home.txt";
        };

        keyFile = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          default = null;
        };

        sopsFile = lib.mkOption {
          type = lib.types.str;
          default = "${config.home.username}-home/${config.home.username}.yaml";
        };
      };

      config = {
        sops.age.keyFile =
          if cfg.keyFile != null then
            cfg.keyFile
          else if isNixOS then
            "/run/secrets/age/${cfg.keyName}"
          else
            "${config.home.homeDirectory}/.config/sops/age/${cfg.keyName}";

        sops.defaultSopsFile = secretsDir + "/${cfg.sopsFile}";

        home.packages = [
          pkgs.age
          pkgs.sops
        ];
      };
    };
}
