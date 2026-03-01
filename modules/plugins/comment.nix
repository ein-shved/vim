{ config, lib, ... }:
{
  plugins.comment = {
    enable = true;
    settings = {
      pre_hook = lib.optionalString config.plugins.ts-context-commentstring.enable ''
        require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      '';

      opleader = {
        block = "gb";
        line = "gc";
      };
      toggler = {
        block = "gbc";
        line = "gcc";
      };
    };
  };
  plugins.ts-context-commentstring.enable = config.plugins.treesitter.enable;
}
