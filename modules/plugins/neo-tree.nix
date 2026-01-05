{ ... }:
{
  plugins.neo-tree = {
    enable = true;
    settings = {
      filesystem = {
        hijack_netrw_behavior = "open_current";
      };
      buffers = {
        follow_current_file = {
          enabled = false;
        };
      };
      window = {
        position = "current";
      };
    };
  };
  userCommands = {
    Ex = {
      command = ":Neotree reveal";
    };
  };
}
