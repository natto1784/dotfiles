{config, pkgs, ...}:
let
  plugs = {
    floaterm = {
      config = ''
        let g:floaterm_keymap_toggle = '<F1>'
        let g:floaterm_keymap_next   = '<F2>'
        let g:floaterm_keymap_prev   = '<F3>'
        let g:floaterm_keymap_new    = '<F4>'

        let g:floaterm_gitcommit='floaterm'
        let g:floaterm_autoinsert=1
        let g:floaterm_width=0.8
        let g:floaterm_height=0.8
        let g:floaterm_wintitle=0
        let g:floaterm_shell="/usr/bin/env zsh"
        '';
      plugin = pkgs.vimPlugins.vim-floaterm;
    };
    nvim-colorizer = {
      plugin = pkgs.vimPlugins.nvim-colorizer-lua;
      config = ''
        packadd! nvim-colorizer.lua
        lua require'colorizer'.setup()
        '';
    };
    auto-pairs = {
      plugin = pkgs.vimPlugins.auto-pairs;
    };
    vim-closetag = {
      config = ''
        let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js,*.erb,*.jsx"
        let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.erb'
        let g:closetag_emptyTags_caseSensitive = 1
        let g:closetag_shortcut = '>'
        let g:closetag_close_shortcut = '<leader>>'
        '';
      plugin = pkgs.vimPlugins.vim-closetag;
    };
    nerdcommenter = {
      config = ''
        map <C-c> <plug>NERDCommenterToggle
        map <C-d> <plug>NERDCommenterSexy
        '';
      plugin = pkgs.vimPlugins.nerdcommenter;
    };
    vim-rooter = {
      plugin = pkgs.vimPlugins.vim-rooter;
    };
    vim-polyglot = {
      plugin = pkgs.vimPlugins.vim-polyglot;
    };
    themes = {
      gruvbox = {
        plugin = pkgs.vimPlugins.gruvbox;
      };
    };
  };
in
  {
    programs.neovim = {
      enable = true;
      vimAlias = false;
      viAlias = false;
      withNodeJs = false;
      withPython = false;
      extraConfig = ''
        let g:gruvbox_italic=1
        let g:gruvbox_contrast_dark="hard"
        let g:gruvbox_contrast_light="hard"
        set background=dark
        colorscheme gruvbox
        '' +
        builtins.readFile ../../config/nvim/init.vim +
        builtins.readFile ../../config/nvim/utils.vim;
      plugins = with plugs; [
        auto-pairs
       # nvim-colorizer
        floaterm
        vim-rooter
        nerdcommenter
        vim-polyglot
        vim-closetag
        themes.gruvbox
      ];
    };
  }
          
