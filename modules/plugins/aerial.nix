{
  plugins.aerial = {
    enable = true;
    settings = {
      highlight_on_hover = true;
      layout = {
        max_width = [ 60 0.5 ];
        default_direction = "prefer_left";
      };
    };
  };
  keymaps = [
    {
      key = "<leader>a";
      action = ":silent! AerialToggle<CR>";
      mode = [ "n" ];
    }
    {
      key = "}";
      action = ":silent! AerialNext<CR>";
      mode = [ "n" "v" ];
    }
    {
      key = "{";
      action = ":silent! AerialPrev<CR>";
      mode = [ "n" "v" ];
    }
  ];
}
