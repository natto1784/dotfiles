{ config, pkgs, inputs, ... }:
let
  mymacs = config: # with inputs.emacs-overlay.packages.${pkgs.system}; already resolved with overlay
    with pkgs; emacsWithPackagesFromUsePackage {
      inherit config;
      package = emacs-pgtk;
      alwaysEnsure = true;
      alwaysTangle = true;
      extraEmacsPackages = epkgs: with epkgs; [
        use-package
        (epkgs.tree-sitter-langs.withPlugins (_: epkgs.tree-sitter-langs.plugins))
      ];
    };
in
{
  home = {
    file = with config; {
      "config.org" = {
        source = ./config/emacs/config.org;
        target = "${home.homeDirectory}/.emacs.d/config.org";
      };
      "init.el" = {
        source = ./config/emacs/init.el;
        target = "${home.homeDirectory}/.emacs.d/init.el";
      };
    };
    shellAliases = rec {
      e = "emacs";
      enw = e + " -nw";
      ec = "emacsclient";
      ecc = ec + " -c";
      ecnw = ec + " -nw";
    };
  };
  programs.emacs = {
    enable = true;
    package = mymacs ./config/emacs/config.org;
  };
  services.emacs.enable = true;
}
