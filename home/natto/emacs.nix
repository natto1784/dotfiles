{ config, pkgs, inputs, lib, ... }:
let
  emacs = pkgs.emacs-pgtk;
  configFile = ./config/emacs/config.org;
  enable = true;
in
{
  nixpkgs.overlays = [ inputs.emacs-overlay.overlays.default ];

  home = {
    shellAliases = rec {
      e = "emacs";
      enw = e + " -nw";
      ec = "emacsclient";
      ecc = ec + " -c";
      ecnw = ec + " -nw";
    };
  };
  programs.emacs = {
    inherit enable;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = configFile;
      package = emacs;
      alwaysEnsure = true;
      alwaysTangle = true;
      defaultInitFile = true;
      extraEmacsPackages = epkgs: with epkgs; [
        use-package
        (tree-sitter-langs.withPlugins (_: tree-sitter-langs.plugins))
      ];
    };
  };
  services.emacs = {
    inherit enable;
    defaultEditor = true;
  };
  systemd.user.services.emacs.Service.Environment = "COLORTERM=truecolor";
}
