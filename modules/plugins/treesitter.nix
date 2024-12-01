{ ... }:
{
  plugins.treesitter = {
    enable = true;
    nixvimInjections = true;
    settings = {
      auto_install = false;
      highlight.enable = true;
      ident.enable = true;
    };
  };
}
