{ pkgs, ... }:
{
  plugins = {
    lsp = {
      enable = true;
      keymaps = {
        diagnostic = {
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
        };
        lspBuf = {
          "<leader>K" = "hover";
          "<leader>gD" = "references";
          "<leader>gd" = "definition";
          "<leader>gi" = "implementation";
          "<leader>gt" = "type_definition";
          "<leader>fm" = "format";
        };
      };
    };
    lsp.servers = {
      bashls.enable = true;
      clangd.enable = true;
      cmake.enable = true;
      lua-ls.enable = true;
      marksman.enable = true;
      nixd = {
        enable = true;
        settings.formatting.command = [
          "${pkgs.nixfmt-rfc-style}/bin/nixfmt"
          "-w"
          "80"
        ];
      };
      pylsp.enable = true;
      rust-analyzer = {
        enable = true;
        # Going to use compilers from devshell
        installCargo = false;
        installRustc = false;
      };
    };
  };
}
