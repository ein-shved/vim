{
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    optional
    types
    mkIf
    concatStringsSep
    map
    ;
  inherit (lib.nixvim.lua) toLua;
  inherit (lib.nixvim.defaultNullOpts) mkBool mkListOf;
  mkKeyModes = mkListOf lib.nixvim.keymaps.modeType;
  cfg = config.plugins.langmapper;
in
lib.nixvim.plugins.mkNeovimPlugin {
  name = "langmapper";
  package = "langmapper-nvim";
  url = "https://github.com/Wansmer/langmapper.nvim";
  description = "A plugin that makes Neovim more friendly to non-English input methods";
  maintainers = [ lib.maintainers.shved ];
  settingsOptions = {
    map_all_ctrl = mkBool true "Add mapping for every CTRL+ binding or not";
    ctrl_map_modes = mkKeyModes [
      "n"
      "o"
      "i"
      "c"
      "t"
      "v"
    ] "Modes to `map_all_ctrl`";
    hack_keymap = mkBool true "Wrap all keymap's functions (nvim_set_keymap etc)";
    disable_hack_modes = mkKeyModes [
      "i"
    ] "Usually you don't want insert mode commands to be translated when hacking";
    automappings_modes = mkKeyModes [
      "n"
      "v"
      "x"
      "s"
    ] "Modes whose mappings will be checked during automapping";
  };
  extraOptions = {
    automapping = {
      enable = mkEnableOption "automapping calling at the end of init.lua";
      global = mkEnableOption "automapping for globbal" // {
        default = true;
      };
      buffer = mkEnableOption "automapping for buffer";
    };
    langmap = {
      enable = mkEnableOption "language mappings configuration";
      default_layout = mkOption {
        description = "String with default layout keys. Will be escaped automatically";
        type = types.str;
        default = ''`qwertyuiop[]asdfghjkl;'zxcvbnm~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>'';
      };
      local_layouts = mkOption {
        description = "List of localized layouts to perform mappings from";
        type = with types; listOf str;
        default = [ ];
        apply =
          res:
          optional cfg.langmap.cyrillic ''ёйцукенгшщзхъфывапролджэячсмитьËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ''
          ++ res;
      };
      cyrillic = mkEnableOption "cyrillic layout";
      # TODO: add more layouts;
    };
  };
  extraConfig = mkIf cfg.enable {
    extraConfigLuaPre = mkIf cfg.langmap.enable ''
      local function _configure_langmap()
        local function escape(str)
          -- You need to escape these characters to work correctly
          local escape_chars = [[;,."|\]]
          return vim.fn.escape(str, escape_chars)
        end

        local default_layout = escape([[${cfg.langmap.default_layout}]])

        vim.opt.langmap =
        vim.fn.join({${
          let
            makeMap = local: "escape([[${local}]]) .. ';' .. default_layout";
          in
          concatStringsSep "," (map makeMap cfg.langmap.local_layouts)
        }}, ',')
      end
      _configure_langmap()
    '';
    extraConfigLuaPost = mkIf cfg.automapping.enable ''
      require("langmapper").automapping({
        global = ${toLua cfg.automapping.global},
        buffer = ${toLua cfg.automapping.buffer}
      })
    '';
  };
}
