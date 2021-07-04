{config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    defaultEditor = true;
    configure = {
      customRC = "lua << EOF\n" + builtins.readFile ./nvim/init.lua + "\nEOF\n";
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          nvim-colorizer-lua
          auto-pairs 
          vim-floaterm 
          vim-closetag
          vim-floaterm
          nerdcommenter
          vim-startify
          nvim-compe
          nvim-lspconfig
          barbar-nvim
          nvim-web-devicons
          vim-rooter
          vim-polyglot
          nvim-tree-lua
          presence-nvim
          indentLine
          vim-vsnip
          (gruvbox.overrideAttrs (oa: { patches = [ ./nvim/gruvbox.patch ]; }))
        ];
      };
    };
  };
}
