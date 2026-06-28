{ inputs, ... }:
{
  flake.homeModules.r3sMail =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
      ];

      sops.secrets."accounts/radicale" = { };
      vdirsyncer.enable = true;
      services.vdirsyncer.enable = true;
      programs.vdirsyncer.enable = true;

      programs.khal.enable = true;
      programs.khal.settings.default.default_calendar = "personal";
      programs.khard.enable = true;

      accounts.calendar.basePath = ".local/share/pim/calendars";

      accounts.calendar.accounts.radicaleCal = {
        primary = true;
        local = {
          type = "filesystem";
          fileExt = ".ics";
        };

        remote = {
          type = "caldav";
          url = "https://radicale.stoeckl.dev/";
          userName = "richi";
          passwordCommand = [
            "cat"
            config.sops.secrets."accounts/radicale".path
          ];
        };

        vdirsyncer = {
          enable = true;
          collections = [
            "from a"
            "from b"
          ];
          metadata = [
            "displayname"
            "color"
          ];
          conflictResolution = "remote wins";
        };

        khal = {
          enable = true;
          type = "discover";
        };
      };

      accounts.contact.basePath = ".local/share/pim/contacts";

      accounts.contact.accounts.radicaleCard = {
        local = {
          type = "filesystem";
          fileExt = ".ics";
        };

        remote = {
          type = "carddav";
          url = "https://radicale.stoeckl.dev/";
          userName = "richi";
          passwordCommand = [
            "cat"
            config.sops.secrets."accounts/radicale".path
          ];
        };

        vdirsyncer = {
          enable = true;
          collections = [
            "from a"
            "from b"
          ];
          metadata = [
          ];
          conflictResolution = "remote wins";
        };

        khard = {
          enable = true;
          type = "discover";
        };
      };

      programs.aerc = {
        enable = true;

        extraConfig = {
          compose = {
            editor = "nvim";
            address-book-cmd = "khard email --parsable %s";
          };

          filters = {
            "text/calendar" = "calendar";
            "text/html" = "html | colorize";
          };
        };
      };

      services.protonmail-bridge.enable = true;

      programs.msmtp.enable = true;
      programs.mbsync.enable = true;
      services.mbsync = {
        enable = true;
        frequency = "*:0/5"; # every 5 minutes
      };

      accounts.email.maildirBasePath = "mail";

      accounts.email.accounts.aon = {
        primary = true;
        neomutt = {
          enable = true;
        };
        address = "richard.stoeckl@aon.at";
        realName = "Richard Stöckl";
        userName = "aon.914895303.2";
        passwordCommand = "pass email/aon | head -n 1";
        smtp = {
          host = "securemail.a1.net";
          port = 587;
          authentication = "plain";
          tls.enable = true;
          tls.useStartTls = true;
        };
        imap = {
          host = "securemail.a1.net";
          port = 993;
          tls.enable = true;
          tls.useStartTls = false;
        };
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        gpg.signByDefault = true;
      };

      programs.neomutt = {
        enable = true;
        vimKeys = true;

        settings = {
          sendmail = "${pkgs.msmtp}/bin/msmtp";
        };
      };
    };
}
