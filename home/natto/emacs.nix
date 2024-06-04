{ config, pkgs, inputs, lib, ... }:
let
  emacs = pkgs.emacs-pgtk;
  configFile = ./config/emacs/config.org;
  enable = true;
in
{
  nixpkgs.overlays = [ inputs.emacs-overlay.overlays.default ];

  home = {
    file = {
      "init.el" = {
        source = pkgs.runCommandLocal "tangle-emacs" { } ''
          ${pkgs.coreutils}/bin/ln -s ${configFile} ./config.org
          ${emacs}/bin/emacs -Q --batch ./config.org -f org-babel-tangle
          cp ./config.el $out
        '';
        target = "${config.home.homeDirectory}/.emacs.d/init.el";
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
    inherit enable;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = configFile;
      package = emacs;
      alwaysEnsure = true;
      alwaysTangle = true;
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
