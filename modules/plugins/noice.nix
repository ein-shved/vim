{ ... }:
{
  plugins.noice = {
    enable = true;
    settings.views = {
      # Switch all relatives from editor to win
      popupmenu.relative = "win";
      popup.relative = "win";
      cmdline.relative = "win";
      cmdline_popup.relative = "win";
      confirm.relative = "win";
      split.relative = "win";
    };
    settings.cmdline = {
      view = "cmdline";
      opts = {
        border = {
          style = "rounded";
        };
        win_options = {
          winhighlight = {
            Normal = "NoiceCmdlinePopup";
            FloatTitle = "NoiceCmdlinePopupTitle";
            FloatBorder = "NoiceCmdlinePopupBorder";
            IncSearch = "";
            CurSearch = "";
            Search = "";
          };
          winbar = "";
          foldenable = false;
          cursorline = false;
        };
        size = {
          min_width = 60;
          width = "auto";
          height = "auto";
        };
        position = {
          row = "99%";
          col = 2;
        };
      };
    };
  };
  plugins.nui.enable = true;
  plugins.notify = {
    enable = true;
    settings.top_down = false;
  };
}
