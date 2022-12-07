{ inputs, config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    # package = inputs.nvim-overlay.packages.${pkgs.system}.default;
    #   package = pkgs.neovim-nightly.overrideAttrs (_:{
    #     nativeBuildInputs = with pkgs; [ unzip cmake pkgconfig gettext tree-sitter ];
    #   });
    defaultEditor = false;
    configure = {
      customRC = ''
        lua << EOF
        ${builtins.readFile ./init.lua}
        EOF
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          nvim-colorizer-lua
          bracey-vim
          auto-pairs
          vim-floaterm
          vim-closetag
          nerdcommenter
          nvim-cmp
          luasnip
          friendly-snippets
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
          (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
          vim-latex-live-preview
          lspkind-nvim
          base16-vim
        ];
      };
    };
  };
}
