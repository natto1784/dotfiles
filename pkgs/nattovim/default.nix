{ wrapNeovimUnstable, neovimUtils, neovim-unwrapped, nvimPackage ? neovim-unwrapped, vimPlugins, ... }:
let
  nvimConfig = neovimUtils.makeNeovimConfig {
    plugins = with vimPlugins; [
      nvim-colorizer-lua
      autoclose-nvim
      toggleterm-nvim
      luasnip
      nvim-cmp
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-path
      cmp-calc
      cmp-emoji
      cmp-buffer
      barbar-nvim
      nvim-web-devicons
      presence-nvim
      nvim-tree-lua
      nvim-treesitter
      lspkind-nvim
      catppuccin-nvim
      telescope-nvim
    ];
  };
in
wrapNeovimUnstable nvimPackage (nvimConfig // {
  luaRcContent = ''
    ${builtins.readFile ./init.lua}
  '';
})
/* wrapNeovim nvimPackage {
  configure = {
      customRC = ''
          ${builtins.readFile ./init.lua}
      '';
      packages.myVimPackage = with vimPlugins; {
        start = [
          nvim-colorizer-lua
          autoclose-nvim
          toggleterm-nvim
          nvim-cmp
          nvim-lspconfig
          cmp-nvim-lsp
          cmp-path
          cmp-calc
          cmp-emoji
          cmp-buffer
          barbar-nvim
          nvim-web-devicons
          presence-nvim
          nvim-tree-lua
          nvim-treesitter
          lspkind-nvim
          catppuccin-nvim
        ];
      };
  };
  }*/
