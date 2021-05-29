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
          nvim-colorizer-lua
          auto-pairs 
          vim-floaterm 
          vim-rooter
          vim-closetag
          vim-floaterm
          nerdcommenter
          vim-startify
          nvim-compe
          nvim-lspconfig
          barbar-nvim
          nvim-web-devicons
          vim-polyglot
          (gruvbox.overrideAttrs (oa: { patches = [ ./nvim/gruvbox.patch ]; }))
 #         (gruvbox.overrideAttrs (oa: { src = pkgs.fetchFromGitHub{} }))
        ];
      };
    };
  };
}
          
