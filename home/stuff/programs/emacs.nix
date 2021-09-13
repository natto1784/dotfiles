{ pkgs, config, ... }:
{
  programs.emacs = {
    enable = false;
    extraPackages = epkgs: with epkgs; [
      elcord
      gruvbox-theme
      ivy
      rainbow-delimiters
      evil
      evil-colemak-basics
      treemacs
      treemacs-evil
      lsp-mode
      lsp-treemacs
      lsp-ui
      tree-sitter
      tree-sitter-langs
      tsc
    ];
    overrides = self: super : {
      tsc = super.tsc.overrideAttrs(oa: 
      let
        tsc-dyn = version: pkgs.fetchurl { 
          url = "https://github.com/emacs-tree-sitter/elisp-tree-sitter/releases/download/${version}/tsc-dyn.so";
          sha256 = "sha256-oOq/TAooHRUo7JypCblrB/ztABowAHv2LRhFL/ZmVrg=";
        };
      in { postInstall = oa.postInstall or "" + "cp ${tsc-dyn "0.15.2"} $out/share/emacs/site-lisp/elpa/tsc-${super.tsc.version}/tsc-dyn.so" ;});
      tree-sitter-langs = pkgs.symlinkJoin rec {
        name = "tree-sitter-langs";
        paths =
          let
            tree-sitter-grammars = pkgs.stdenv.mkDerivation rec {
              name = "tree-sitter-grammars";
              version = "0.10.4";
              src = pkgs.fetchzip {
                url = "https://github.com/emacs-tree-sitter/tree-sitter-langs/releases/download/${version}/tree-sitter-grammars-linux-${version}.tar.gz";
                sha256 = "sha256-Z+JtuGLTCVhCJBR60cbcDgWtdKcoYGWoeI5u9GcfvUQ=";
                stripRoot = false;
              };
              installPhase = ''
                install -d $out/langs/bin
                install -m444 * $out/langs/bin
                echo -n $version > $out/langs/bin/BUNDLE-VERSION
              '';
            };
          in
          [
            (super.tree-sitter-langs.overrideAttrs (oldAttrs: {
              postPatch = oldAttrs.postPatch or "" + ''
                substituteInPlace ./tree-sitter-langs-build.el \
                --replace "tree-sitter-langs-grammar-dir tree-sitter-langs--dir"  "tree-sitter-langs-grammar-dir \"${tree-sitter-grammars}/langs\""
              '';
            }))
            tree-sitter-grammars
          ];
      };
    };
  };
  home.file.emacs = {
    source = ../../config/emacs/init.el;
    target = "${config.home.homeDirectory}/.emacs.d/init.el";
  };
}
