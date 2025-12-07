{
  lib,
  config,
  ...
}:
let
  inherit (lib)
    concatStringsSep
    ;
  default_layout = ''`qwertyuiop[]asdfghjkl;'zxcvbnm~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>'';
  local_layouts = [ ''ёйцукенгшщзхъфывапролджэячсмитьËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ'' ];
in
{
  plugins.langmapper = {
    enable = true;
    automapping.enable = true;
  };
  extraConfigLuaPre = ''
    local function _configure_langmap()
      local function escape(str)
        -- You need to escape these characters to work correctly
        local escape_chars = [[;,."|\]]
        return vim.fn.escape(str, escape_chars)
      end

      local default_layout = escape([[${default_layout}]])

      vim.opt.langmap =
      vim.fn.join({${
        let
          makeMap = local: "escape([[${local}]]) .. ';' .. default_layout";
        in
        concatStringsSep "," (map makeMap local_layouts)
      }}, ',')
    end
    _configure_langmap()
  '';
}
