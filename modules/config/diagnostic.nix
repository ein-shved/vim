{ helpers, ... }:
{
  diagnostic.settings = {
    virtual_text = false;
    underline = true;
    float.border = "rounded";
    signs.text = helpers.mkRaw ''
      {
        [vim.diagnostic.severity.ERROR] = "󰅙",
        [vim.diagnostic.severity.WARN]  = "",
        [vim.diagnostic.severity.INFO]  = "󰋼",
        [vim.diagnostic.severity.HINT]  = "󰌵",
      }
    '';
  };
}
