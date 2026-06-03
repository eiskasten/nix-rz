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

            output = {
              criteria = "Dell Inc. DELL U2722D FPJM8H3";
              mode = "2560x1440";
              scale = 1.0;
              transform = "normal";
              alias = "OFFICE_CENTER";
            };
          }

          {
            output = {
              criteria = "Dell Inc. DELL U2722D GTJM8H3";
              mode = "2560x1440";
              scale = 1.0;
              transform = "normal";
              alias = "OFFICE_RIGHT";
            };
          }

          {
            output = {
              criteria = "Dell Inc. DELL U2722D 3MLN6P3";
              mode = "2560x1440";
              scale = 1.0;
              transform = "normal";
              alias = "MATTHIAS_CENTER";
            };
          }

          {
            output = {
              criteria = "Dell Inc. DELL U2722D 8ZLN6P3";
              mode = "2560x1440";
              scale = 1.0;
              transform = "normal";
              alias = "MATTHIAS_RIGHT";
            };
          }
          {
            output = {
              criteria = "Dell Inc. DELL U3415W F1T1W9CC0PPL";
              mode = "3440x1440";
              scale = 1.0;
              transform = "normal";
              alias = "DAVID_CENTER";
            };
          }

          {
            output = {
              criteria = "Dell Inc. DELL U2722D DQJM8H3";
              mode = "2560x1440";
              scale = 1.0;
              transform = "90";
              alias = "DAVID_RIGHT";
            };
          }
          {
            output = {
              criteria = "Dell Inc. DELL U2421E G2P39P3";
              mode = "1920x1200";
              scale = 1.0;
              alias = "TEL_BIG";
            };
          }

          {
            output = {
              criteria = "Dell Inc. DELL U2724D 2L8F834";
              mode = "2560x1440";
              scale = 1.0;
              transform = "normal";
              alias = "LENNY_CENTER";
            };
          }

          {
            output = {
              criteria = "Dell Inc. DELL U2722D 7VN7WN3";
              mode = "2560x1440";
              scale = 1.0;
              transform = "270";
              alias = "LENNY_LEFT";
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

          {
            profile = {
              name = "office";
              outputs = [
                {
                  criteria = "$INTERNAL";
                  status = "enable";
                }
                {
                  criteria = "$OFFICE_CENTER";
                  status = "enable";
                  position = "1920,0";
                }
                {
                  criteria = "$OFFICE_RIGHT";
                  status = "enable";
                  position = "4480,0";
                }
              ];
            };
          }

          {
            profile = {
              name = "matthias";
              outputs = [
                {
                  criteria = "$INTERNAL";
                  status = "enable";
                }
                {
                  criteria = "$MATTHIAS_CENTER";
                  status = "enable";
                  position = "1920,0";
                }
                {
                  criteria = "$MATTHIAS_RIGHT";
                  status = "enable";
                  position = "4480,0";
                }
              ];
            };
          }

          {
            profile = {
              name = "david";
              outputs = [
                {
                  criteria = "$INTERNAL";
                  status = "enable";
                }
                {
                  criteria = "$DAVID_CENTER";
                  status = "enable";
                  position = "1920,0";
                }
                {
                  criteria = "$DAVID_RIGHT";
                  status = "enable";
                  position = "5360,-670";
                }
              ];
            };
          }

          {
            profile = {
              name = "lenny";
              outputs = [
                {
                  criteria = "$INTERNAL";
                  status = "enable";
                }
                {
                  criteria = "$LENNY_CENTER";
                  status = "enable";
                  position = "-2560,0";
                }
                {
                  criteria = "$LENNY_LEFT";
                  status = "enable";
                  position = "-4000,-670";
                }
              ];
            };
          }

          {
            profile = {
              name = "telbig";
              outputs = [
                {
                  criteria = "$INTERNAL";
                  status = "enable";
                  position = "0,1200";
                }
                {
                  criteria = "$TEL_BIG";
                  status = "enable";
                  position = "-2560,0";
                }
              ];
            };
          }
        ];
      };

    };
}
