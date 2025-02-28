{ helpers, ... }:
{
  opts = {
    number = false;
    wrap = false;

    guifont = "JetBrainsMono Nerd Font:h10";

    ruler = true;
    laststatus = 2;

    list = true;
    listchars = "tab:→ ,nbsp:␣,trail:•,precedes:«,extends:»";

    tw = 80;
    colorcolumn = "81";
    backspace = "indent,eol,start";
    expandtab = true;
    autoindent = true;
    smartindent = true;
    tabstop = 4;
    shiftwidth = 4;

    formatoptions = "croql";

    hidden = false;

    spell = true;
    spelllang = "en,ru";

    undodir = helpers.mkRaw ''
      vim.fn.expand('$HOME/.vim/undodir')
    '';
    undofile = true;
  };
  autoCmd = [
    {
      event = "BufWritePre";
      pattern = "*";
      command = '':%s/\s\+$//e'';
    }
    {
      event = "FileType";
      pattern = [
        "xml"
        "nix"
        "lua"
        "json"
        "yaml"
      ];
      callback = helpers.mkRaw ''
        function()
            vim.opt_local.tabstop = 2;
            vim.opt_local.shiftwidth = 2;
        end
      '';
    }
  ];
}
