{ lib, config, ... }:
{
  plugins.treesitter = {
    enable = config.setup.development;
    grammarPackages = lib.mkIf (!config.setup.development) [];
    nixvimInjections = true;
    settings = {
      auto_install = false;
      highlight.enable = true;
      ident.enable = true;
    };
  };
}
