{ lib, ... }:
{
  extraConfigLuaPre = ''
    vim.g.mapleader = ' '
    local function fontcfg(add)
      local m = string.gmatch(vim.o.guifont, '([^(:h)]+)')
      local font = m()
      local h = m()
      local nh = 8
      if not font then
        return
      end
      if h then
        nh = tonumber(h) + add
      end
      vim.o.guifont = font .. ":h" .. tostring(nh)
    end
  '';
  keymaps = [
    {
      key = "<C-s>";
      action = "<cmd>wa<CR>";
      mode = [
        "i"
        "n"
      ];
    }
    {
      key = "<C-->";
      action = lib.nixvim.mkRaw "function() fontcfg(-1) end";
      mode = [
        "n"
      ];
    }
    {
      key = "<C-+>";
      action = lib.nixvim.mkRaw "function() fontcfg(1) end";
      mode = [
        "n"
      ];
    }
    {
      key = "<S-Insert>";
      action = "<C-r>*";
      mode = [
        "i"
        "c"
        "n"
      ];
    }
    {
      key = "<S-Insert>";
      action = "<C-r>*";
      mode = [
        "i"
        "c"
        "n"
      ];
    }
    {
      key = "<C-S-v>";
      action = "<C-r>+";
      mode = [
        "i"
        "c"
        "n"
      ];
    }
    {
      key = "<C-S-c>";
      action = "y";
      mode = [
        "v"
      ];
    }
    {
      key = "<Esc><Esc>";
      action = ":silent nohlsearch<CR>";
      mode = [
        "n"
      ];
    }
  ];
}
