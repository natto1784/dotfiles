{pkgs, ... }:
{
services.emacs = {
  enable = true;
  package = with pkgs; emacsWithPackagesFromUsePackage {
    config = ./init.el;
    package = emacsGcc;
    alwaysEnsure = true;
    extraEmacsPackages = epkgs: with epkgs; [
      use-package
      tsc
    ];

    #https://github.com/NixOS/nixpkgs/issues/108089
    override = epkgs : epkgs // {
      tsc = epkgs.melpaPackages.tsc.overrideAttrs(oa: 
      let 
        version = "0.15.2";
        tsc-dyn = fetchurl {
          url = "https://github.com/emacs-tree-sitter/elisp-tree-sitter/releases/download/${version}/tsc-dyn.so";
          sha256 = "sha256-oOq/TAooHRUo7JypCblrB/ztABowAHv2LRhFL/ZmVrg=";
        };
        in {
          postInstall = ''
            cp ${tsc-dyn} $out/share/emacs/site-lisp/elpa/tsc-${oa.version}/tsc-dyn.so
            echo -n ${version} > $out/share/emacs/site-lisp/elpa/tsc-${oa.version}/DYN-VERSION
          '';
        });
      tree-sitter-langs = epkgs.melpaPackages.tree-sitter-langs.overrideAttrs (oa:
      let
        tree-sitter-grammars = super.stdenv.mkDerivation rec {
          name = "tree-sitter-grammars";
          version = "0.10.7";
          src = fetchzip {
            url = "https://github.com/emacs-tree-sitter/tree-sitter-langs/releases/download/${version}/tree-sitter-grammars-linux-${version}.tar.gz";
            sha256 = "sha256-pdSMyTUUAj4JsRLbJMUMbQSOaSEYlsaqVdmaXtXtSJw=";
            stripRoot = false;
          };
          installPhase = ''
            install -d $out/langs/bin
            install -m444 * $out/langs/bin
          '';
          postInstall = ''          
            echo -n "${version}" > $out/langs/bin/BUNDLE-VERSION
          '';
        };
        in {
          postPatch = oa.postPatch or "" + ''
            substituteInPlace ./tree-sitter-langs-build.el \
            --replace "tree-sitter-langs-grammar-dir tree-sitter-langs--dir"  "tree-sitter-langs-grammar-dir \"${tree-sitter-grammars}/langs\""
          '';
        });
      gruvbox-theme = epkgs.melpaPackages.gruvbox-theme.overrideAttrs(_: { patches = [ ./gruvbox-el.patch ]; } );
    };
  };};
}
