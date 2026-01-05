{ lib, ... }:
{
  plugins.lualine = {
    enable = true;
    # Choose light theme for status line and switch it back to generic within
    # inactive state to make active window most notable
    luaConfig.pre = ''
      function lualine_make_inactive_custom(theme_name)
        local theme = require("lualine.themes." .. theme_name)
        local base16 = require("lualine.themes.base16")

        theme.inactive = base16.inactive
        return theme
      end
    '';
    settings =
      let
        lualine_c = [
          (
            lib.nixvim.listToUnkeyedAttrs [ "filename" ]
            // {
              path = 4;
            }
          )
        ];
      in
      {
        options.theme = lib.nixvim.mkRaw ''lualine_make_inactive_custom("papercolor_light")'';
        sections = {
          lualine_b = [ "diagnostics" ];
          inherit lualine_c;
          lualine_x = lib.nixvim.emptyTable;
        };
        inactive_sections = {
          inherit lualine_c;
        };
      };
  };
}
