{
  plugins.gitblame = {
    enable = true;
    settings = {
      message_template = "<author> • <sha>";
      message_when_not_committed = "";
    };
  };
  keymaps = [
    {
      key = "<leader>gy";
      action = ":GitBlameCopySHA<CR>";
      mode = "n";
      options.desc = "Copy blame SHA";
    }
  ];
}
