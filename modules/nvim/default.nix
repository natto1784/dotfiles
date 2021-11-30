{config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
 #   package = pkgs.neovim-nightly.overrideAttrs (_:{
 #     nativeBuildInputs = with pkgs; [ unzip cmake pkgconfig gettext tree-sitter ];
 #   });
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
          nerdcommenter
          nvim-compe
          nvim-lspconfig
          barbar-nvim
          presence-nvim
          nvim-web-devicons
          nvim-tree-lua
          vim-vsnip
          nvim-treesitter
          vim-latex-live-preview
          (gruvbox.overrideAttrs (oa: { patches = [ ./gruvbox.patch ]; }))
        ];
      };
    };
  };
}
