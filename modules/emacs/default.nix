{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    (emacsWithPackagesFromUsePackage {
      config = ./init.el;
      package = emacsGcc;
      alwaysEnsure = true;
      extraEmacsPackages = epkgs: with epkgs; [
        use-package
        tsc
      ];
      override = epkgs : epkgs // {
        tsc = epkgs.melpaPackages.tsc.overrideAttrs(oa: 
        let 
          version = "0.15.1";
          tsc-dyn = fetchurl {
            url = "https://github.com/emacs-tree-sitter/elisp-tree-sitter/releases/download/${version}/tsc-dyn.so";
            sha256 = "sha256-TrwyQZEfARHfafT4IhxR+p7vpjSuw9lUcgOSwCvPxe4=";
          };
          version-file = writeText "DYN-VERSION" version;
        in {
/*          src = fetchFromGitHub {
            owner = "emacs-tree-sitter";
            repo = "elisp-tree-sitter";
            rev = version;
            sha256 = "sha256-dGWg4dj+85kxytvm+nNEJUN9UXdr9L6pSRz5OqDMFAM=";
          };*/
          postInstall = ''
            cp ${tsc-dyn} $out/share/emacs/site-lisp/elpa/tsc-${oa.version}/tsc-dyn.so
            cp ${version-file} $out/share/emacs/site-lisp/elpa/tsc-${oa.version}/DYN-VERSION
          '';
        });
        tree-sitter-langs = epkgs.melpaPackages.tree-sitter-langs.overrideAttrs (oa:
        let
          tree-sitter-grammars = super.stdenv.mkDerivation rec {
            name = "tree-sitter-grammars";
            version = "0.10.4";
            src = fetchzip {
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
        in {
            postPatch = oa.postPatch or "" + ''
              substituteInPlace ./tree-sitter-langs-build.el \
              --replace "tree-sitter-langs-grammar-dir tree-sitter-langs--dir"  "tree-sitter-langs-grammar-dir \"${tree-sitter-grammars}/langs\""
            '';
#            postInstall = oa.postInstall or "" + ''
 #             mkdir $out/share/emacs/site-lisp/elpa/tree-sitter-langs-${oa.version}/bin
  #            cp ${binaries}/* $out/share/emacs/site-lisp/elpa/tree-sitter-langs-${oa.version}/bin/
   #         '';
        });
        gruvbox-theme = epkgs.melpaPackages.gruvbox-theme.overrideAttrs(_: { patches = [ ./gruvbox-el.patch ]; } );
      };
    })
  ];
}
