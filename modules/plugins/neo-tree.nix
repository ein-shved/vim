{ ... }:
{
  plugins.neo-tree = {
    enable = true;
    filesystem = {
      hijackNetrwBehavior = "open_current";
    };
    buffers = {
      followCurrentFile = {
        enabled = false;
      };
    };
    window = {
      position = "current";
    };
  };
  userCommands = {
    Ex = {
      command = ":Neotree reveal";
    };
  };
}
