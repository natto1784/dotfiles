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
          nvim-cmp
          cmp_luasnip
          cmp-nvim-lsp
          cmp-path
          cmp-calc
          cmp-emoji
 #         cmp-look
          cmp-buffer
          nvim-lspconfig
          barbar-nvim
          presence-nvim
          nvim-web-devicons
          nvim-tree-lua
          luasnip
          nvim-treesitter
          vim-latex-live-preview
          lspkind-nvim
        # (gruvbox.overrideAttrs (oa: { patches = [ ./gruvbox.patch ]; }))
          base16-vim
        ];
      };
    };
  };
}
