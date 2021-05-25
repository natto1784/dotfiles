{config, pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    configure = {
    customRC = ''
      "theme
      let g:gruvbox_italic=1
      let g:gruvbox_contrast_dark="hard"
        let g:gruvbox_contrast_light="hard"
        set background=dark
        colorscheme gruvbox
        '' +
        builtins.readFile ./nvim/init.vim +
        builtins.readFile ./nvim/utils.vim +
	''
	"Floaterm
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
	'' +
/*	''
	"Colorizer
        packadd! nvim-colorizer.lua
        lua require'colorizer'.setup()
	'' +
*/	''
	"closetag
        let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js,*.erb,*.jsx"
        let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.erb'
        let g:closetag_emptyTags_caseSensitive = 1
        let g:closetag_shortcut = '>'
        let g:closetag_close_shortcut = '<leader>>'
	'' +
	''
	"nerdcommenter
        map <C-c> <plug>NERDCommenterToggle
        map <C-d> <plug>NERDCommenterSexy
	'';

	packages.myVimPackage = with pkgs.vimPlugins; {
              start = [ auto-pairs vim-floaterm vim-rooter vim-polyglot gruvbox vim-closetag vim-floaterm nerdcommenter];
	};
      };
    };
  }
          
