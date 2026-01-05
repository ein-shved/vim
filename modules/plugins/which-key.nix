{ lib, ... }:
{
  plugins.which-key = {
    enable = true;
    settings.win = lib.nixvim.mkRaw ''
      {
        relative = "win",
        width = function()
            return vim.api.nvim_win_get_width(0);
        end,
        border = "rounded",
      }
    '';
  };
}
