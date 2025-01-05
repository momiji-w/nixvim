{ pkgs, ... }:

{
  extraPackages = with pkgs; [ ripgrep ];

  globals = { mapleader = " "; };

  extraConfigLua = ''
    vim.cmd.colorscheme "hatsunemiku"
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  '';

  autoCmd = [{
    command = "lua vim.lsp.buf.format()";
    event = [ "BufWritePre" ];
  }];

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "vim-colors-hatsunemiku";
      src = pkgs.fetchFromGitHub {
        owner = "momiji-w";
        repo = "vim-colors-hatsunemiku";
        rev = "1a90f30d8094123bda149ea86b0b81e2c2a515e9";
        hash = "sha256-kIjoRFslD/wEKUk0OKum8109z/Iq4qpRuERdFMGlSCw=";
      };
    })
  ];

  plugins = {
    telescope = {
      enable = true;
      extensions.fzf-native.enable = true;

      keymaps = {
        "<C-p>" = "git_files";
        "<leader>ff" = "find_files";
        "<leader>fs" = "live_grep";
        "<leader>vh" = "help_tags";
        "<leader>fr" = "lsp_references";
      };
    };

    treesitter.enable = true;
    web-devicons.enable = true;

    clipboard-image = {
      enable = true;
      clipboardPackage = pkgs.wl-clipboard;
    };

    markdown-preview = { enable = true; };

    none-ls = {
      enable = true;
      sources.formatting = {
        yapf.enable = true; # really cool name
        gofumpt.enable = true;
        nixfmt.enable = true;
        mdformat.enable = true;
      };
    };
  };

  opts = {
    number = true;
    relativenumber = true;

    signcolumn = "yes";

    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;

    smartindent = true;

    wrap = false;

    hlsearch = false;
    incsearch = true;

    guicursor = "";

    termguicolors = true;

    scrolloff = 999;

    cc = "80";
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>pv";
      action = ":Ex <CR>";
    }
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
    }
  ];
}
