{ ... }:
{
  flake.nixosModules.localeModule =
    { ... }:
    {
      # Mandatory
      i18n.defaultLocale = "en_US.UTF-8";

      # Optionally
      i18n.extraLocaleSettings = {
        # LC_ALL = "en_US.UTF-8"; # This overrides all other LC_* settings.
        LC_CTYPE = "de_AT.UTF8";
        LC_ADDRESS = "de_AT.UTF-8";
        LC_MEASUREMENT = "de_AT.UTF-8";
        LC_MESSAGES = "en_US.UTF-8";
        LC_MONETARY = "de_AT.UTF-8";
        LC_NAME = "de_AT.UTF-8";
        LC_NUMERIC = "de_CH.UTF-8";
        LC_PAPER = "de_AT.UTF-8";
        LC_TELEPHONE = "de_AT.UTF-8";
        LC_TIME = "de_AT.UTF-8";
        LC_COLLATE = "de_AT.UTF-8";
      };
    };
}
