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
              action = helpers.mkRaw ''require("fastaction").${function}'';
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
        local signs = {
          DiagnosticSignError = "󰅙",
          DiagnosticSignWarn = "",
          DiagnosticSignInfo = "󰋼",
          DiagnosticSignHint = "󰌵",
        }

        for sign,text in pairs(signs) do
          vim.fn.sign_define(sign, {
              text = text,
              texthl = sign,
            })
        end
        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            underline = true,
            float = { border = "rounded" },
          })

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
                if [ -n "$NIX_CLANGD_UNWRAPPED" ]; then
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
          "-w"
          "80"
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
    };
    fastaction.enable = true;
  };
}
