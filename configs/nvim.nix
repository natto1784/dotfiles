{config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    defaultEditor = true;
    configure = {
      customRC ="lua << EOF\n" + builtins.readFile ./nvim/init.lua + "\nEOF\n";
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
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
          (gruvbox.overrideAttrs (oa: { patches = [ ./nvim/gruvbox.patch ]; }))
          (pkgs.vimUtils.buildVimPlugin {
            name = "presence-nvim";
            src = pkgs.fetchFromGitHub {
              owner = "andweeb";
              repo = "presence.nvim";
              rev = "f4c1e227be0a0c863c2de201155401950eda572e";
              sha256 = "08s4az1gv6r5sl0jqkaf4yzibglibb7n2sivh7qccj8dz8id3883";
            };
          })
        ];
      };
    };
  };
}
          
