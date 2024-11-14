{ ... }:
{
  plugins.treesitter = {
    enable = true;
    ensureInstalled = "all";
    nixvimInjections = true;
  };
}
