{ pkgs, config, ... }:
{
  #i dont really use emacs but eh
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      elcord
      gruvbox-theme
      ivy
      rainbow-delimiters
    ];
    overrides = self: super: {
      gruvbox-theme = self.melpaPackages.gruvbox-theme.overrideAttrs(_: {
        patches = [ ../../config/emacs/gruvbox-el.patch ];
      });
    };
  };
  home.file.emacs = {
    source = ../../config/emacs/init.el;
    target = "${config.home.homeDirectory}/.emacs.d/init.el";
  };
}
