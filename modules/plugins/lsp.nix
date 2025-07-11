{ pkgs, helpers, ... }:
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
          "<leader>ra" = "rename";
        };
        extra =
          let
            mkCaKey = mode: function: {
              key = "<leader>ca";
              action = helpers.mkRaw ''
                function ()
                  require("fastaction").${function}()
                end
              '';
              mode = [ mode ];
              options.desc = "Code action";
            };
          in
          [
            (mkCaKey "n" "code_action")
            (mkCaKey "v" "range_code_action")
          ];
      };
      # Partial copy-paste from
      # https://github.com/NvChad/ui/blob/v2.0/lua/nvchad/lsp.lua
      postConfig = ''
        vim.lsp.handlers["textDocument/hover"] =
          vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
          })
        vim.lsp.handlers["textDocument/signatureHelp"] =
          vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
            focusable = false,
            relative = "cursor",
          })

        -- Borders for LspInfo winodw
        local win = require "lspconfig.ui.windows"
        local _default_opts = win.default_opts

        win.default_opts = function(options)
          local opts = _default_opts(options)
          opts.border = "rounded"
          return opts
        end
      '';
    };
    lsp.servers = {
      bashls.enable = true;
      clangd = {
        enable = true;
        cmd =
          let
            clangd =
              let
                inherit (pkgs) writeShellScript llvmPackages;
              in
              writeShellScript "clangd-chooser" ''
                checkLabel() {
                  local rootdir="$1"

                  for label in use-clangd-unwrapped use-clangd; do
                    if [ -e "$rootdir/.nix-$label" ]; then
                      return 0
                    fi
                  done
                  return 1
                }
                rootdir=$PWD
                while ! checkLabel "$rootdir"  && [ "$rootdir" != "/" ]; do
                  rootdir="$(dirname "$rootdir")"
                done
                if [ -e "$rootdir/.nix-use-clangd" ]; then
                  pkg="$rootdir/.nix-use-clangd"
                elif [ -e "$rootdir/.nix-use-clangd-unwrapped" ]; then
                  pkg="${llvmPackages.clang-unwrapped}"
                else
                  pkg="${llvmPackages.clang-tools}"
                fi
                exec "$pkg/bin/clangd" "$@"
              '';
          in
          [
            "${clangd}"
            "-j=8"
            "--query-driver=/home/shved/kl/**/*,/nix/store/**/*,*"
            "--header-insertion=never"
          ];
      };
      cmake.enable = true;
      lua_ls.enable = true;
      marksman.enable = true;
      nixd = {
        enable = true;
        settings.formatting.command = [
          "${pkgs.nixfmt-rfc-style}/bin/nixfmt"
        ];
      };
      pylsp = {
        enable = true;
        settings.configurationSources = "flake8";
        settings.plugins = {
          autopep8.enable = true;
          flake8.enable = true;
          pylint.enable = true;
          ruff.enable = true;
          pylsp_mypy.enable = true;
        };
      };
      pyright.enable = true;
      pylyzer.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      gopls.enable = true;
    };
    fastaction.enable = true;
  };
}
