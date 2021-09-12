{config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped.overrideAttrs (_:{
      nativeBuildInputs = with pkgs.unstable; [ unzip cmake pkgconfig gettext tree-sitter ];
    });
    defaultEditor = true;
    configure = {
    customRC = ''
    lua << EOF
    ${builtins.readFile ./init.lua}
    EOF
    '';
      packages.myVimPackage = with pkgs.unstable.vimPlugins; {
        start = [
          nvim-colorizer-lua
          auto-pairs 
          vim-floaterm 
          vim-closetag
          vim-floaterm
          nerdcommenter
          nvim-compe
          nvim-lspconfig
          barbar-nvim
          presence-nvim
          nvim-web-devicons
          nvim-tree-lua
          vim-vsnip
          nvim-treesitter
          vim-polyglot
          (gruvbox.overrideAttrs (oa: { patches = [ ./gruvbox.patch ]; }))
        ];
      };
    };
  };
}
