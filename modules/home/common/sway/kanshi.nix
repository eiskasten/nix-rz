{ ... }:
{
  flake.homeModules.kanshi =
    { ... }:
    {
      services.kanshi = {
        enable = true;
        settings = [
          {
            output = {
              alias = "INTERNAL";
              criteria = "BOE 0x07DB Unknown";
              mode = "1920x1080@60";
              transform = "normal";
              scale = 1.0;
            };
          }

          {
            output = {
              alias = "KEMPFENDORF_CENTER";
              criteria = "Ancor Communications Inc ASUS VN247 E9LMTF006194";
              mode = "1920x1080@60";
              transform = "normal";
              scale = 1.0;
            };
          }

          {
            profile = {
              name = "kempfendorf";
              outputs = [
                {
                  criteria = "$INTERNAL";
                  position = "1920,0";
                  status = "enable";
                }
                {
                  criteria = "$KEMPFENDORF_CENTER";
                  position = "0,0";
                  status = "enable";
                }
              ];
            };
          }
        ];
      };

    };
}
