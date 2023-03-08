{ config, pkgs, inputs, ... }:
let
  mymacs = config: # with inputs.emacs-overlay.packages.${pkgs.system}; already resolved with overlay
    with pkgs; emacsWithPackagesFromUsePackage {
      inherit config;
      package = emacsPgtkGcc;
      alwaysEnsure = true;
      alwaysTangle = true;
      extraEmacsPackages = epkgs: with epkgs; [
        use-package
        (epkgs.tree-sitter-langs.withPlugins (_: epkgs.tree-sitter-langs.plugins))
      ];
      override = epkgs: epkgs // {
        catppuccin-theme = epkgs.melpaPackages.catppuccin-theme.overrideAttrs (_: {
          src = pkgs.fetchFromGitHub {
            owner = "natto1784";
            repo = "catppuccin-emacs";
            rev = "company";
            sha256 = "sha256-wI+RiOeRrvV5eXXVs6hBb3x9BMD9HgHmsjom7kzAFJg=";
          };
        });
      };
    };
in
{
  home.file = with config; {
    "config.org" = {
      source = ./config/emacs/config.org;
      target = "${home.homeDirectory}/.emacs.d/config.org";
    };
    "init.el" = {
      source = ./config/emacs/init.el;
      target = "${home.homeDirectory}/.emacs.d/init.el";
    };
  };
  programs.emacs = {
    enable = true;
    package = mymacs ./config/emacs/config.org;
  };
  services.emacs.enable = true;
}
