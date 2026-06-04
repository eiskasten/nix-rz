{ ... }:
{
  flake.homeModules.kanshi =
    { lib, config, ... }:

    let
      cfg = config.my.kanshi;

      mkOutput = alias: monitor: {
        output = {
          inherit alias;
          inherit (monitor) criteria mode scale;
          transform = monitor.transform or "normal";
        };
      };

      mkProfile = name: outputs: {
        profile = {
          inherit name outputs;
        };
      };

      enabled = criteria: position: {
        inherit criteria position;
        status = "enable";
      };

      enabledNoPos = criteria: {
        inherit criteria;
        status = "enable";
      };

      pos = x: y: "${toString x},${toString y}";

      internalWidth = cfg.internalMonitor.logical.width;
      internalHeight = cfg.internalMonitor.logical.height;

      monitors = {
        INTERNAL = cfg.internalMonitor;

        KEMPFENDORF_CENTER = {
          criteria = "Ancor Communications Inc ASUS VN247 E9LMTF006194";
          mode = "1920x1080@60";
          scale = 1.0;
        };

        OFFICE_CENTER = {
          criteria = "Dell Inc. DELL U2722D FPJM8H3";
          mode = "2560x1440";
          scale = 1.0;
        };

        OFFICE_RIGHT = {
          criteria = "Dell Inc. DELL U2722D GTJM8H3";
          mode = "2560x1440";
          scale = 1.0;
        };

        MATTHIAS_CENTER = {
          criteria = "Dell Inc. DELL U2722D 3MLN6P3";
          mode = "2560x1440";
          scale = 1.0;
        };

        MATTHIAS_RIGHT = {
          criteria = "Dell Inc. DELL U2722D 8ZLN6P3";
          mode = "2560x1440";
          scale = 1.0;
        };

        DAVID_CENTER = {
          criteria = "Dell Inc. DELL U3415W F1T1W9CC0PPL";
          mode = "3440x1440";
          scale = 1.0;
        };

        DAVID_RIGHT = {
          criteria = "Dell Inc. DELL U2722D DQJM8H3";
          mode = "2560x1440";
          scale = 1.0;
          transform = "90";
        };

        TEL_BIG = {
          criteria = "Dell Inc. DELL U2421E G2P39P3";
          mode = "1920x1200";
          scale = 1.0;
        };

        LENNY_CENTER = {
          criteria = "Dell Inc. DELL U2724D 2L8F834";
          mode = "2560x1440";
          scale = 1.0;
        };

        LENNY_LEFT = {
          criteria = "Dell Inc. DELL U2722D 7VN7WN3";
          mode = "2560x1440";
          scale = 1.0;
          transform = "270";
        };
      };
    in
    {
      options.my.kanshi.internalMonitor = lib.mkOption {
        type = lib.types.submodule {
          options = {
            criteria = lib.mkOption { type = lib.types.str; };
            mode = lib.mkOption { type = lib.types.str; };
            scale = lib.mkOption {
              type = lib.types.float;
              default = 1.0;
            };
            transform = lib.mkOption {
              type = lib.types.str;
              default = "normal";
            };
            logical = {
              width = lib.mkOption { type = lib.types.int; };
              height = lib.mkOption { type = lib.types.int; };
            };
          };
        };
      };

      config.services.kanshi = {
        enable = true;

        settings = lib.mapAttrsToList mkOutput monitors ++ [
          (mkProfile "kempfendorf" [
            (enabled "$INTERNAL" (pos 1920 0))
            (enabled "$KEMPFENDORF_CENTER" (pos 0 0))
          ])

          (mkProfile "office" [
            (enabled "$INTERNAL" (pos 0 0))
            (enabled "$OFFICE_CENTER" (pos internalWidth 0))
            (enabled "$OFFICE_RIGHT" (pos (internalWidth + 2560) 0))
          ])

          (mkProfile "matthias" [
            (enabled "$INTERNAL" (pos 0 0))
            (enabled "$MATTHIAS_CENTER" (pos internalWidth 0))
            (enabled "$MATTHIAS_RIGHT" (pos (internalWidth + 2560) 0))
          ])

          (mkProfile "david" [
            (enabled "$INTERNAL" (pos 0 0))
            (enabled "$DAVID_CENTER" (pos internalWidth 0))
            (enabled "$DAVID_RIGHT" (pos (internalWidth + 3440) (-670)))
          ])

          (mkProfile "lenny" [
            (enabled "$INTERNAL" (pos 0 0))
            (enabled "$LENNY_CENTER" (pos (-2560) 0))
            (enabled "$LENNY_LEFT" (pos (-4000) (-670)))
          ])

          (mkProfile "telbig" [
            (enabled "$INTERNAL" (pos 0 1200))
            (enabled "$TEL_BIG" (pos (-2560) 0))
          ])
        ];
      };
    };
}
