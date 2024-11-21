{ helpers, ... }:
{
  plugins = {
    cmp-nvim-lsp = {
      enable = true;
    }; # lsp
    cmp-buffer = {
      enable = true;
    };
    cmp-path = {
      enable = true;
    }; # file system paths
    cmp-cmdline = {
      enable = true;
    }; # autocomplete for cmdline
    cmp = {
      enable = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          {
            name = "buffer";
            keyword_length = 5;
          }
          {
            name = "path";
            keyword_length = 3;
          }
          {
            name = "luasnip";
            keyword_length = 3;
          }
        ];
        completion = {
          autocomplete = false;
          completeopt = "menu,menuone";
        };

        mapping = {
          "<C-n>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
        formatting = {
          fields = [
            "kind"
            "abbr"
            "menu"
          ];
          expandable_indicator = true;
        };
        performance = {
          debounce = 60;
          fetching_timeout = 200;
          max_view_entries = 30;
        };
        window = {
          completion = {
            border = "rounded";
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
          };
          documentation = {
            border = "rounded";
          };
        };
      };
    };
  };
}
