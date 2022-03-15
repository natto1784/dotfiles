{ pkgs, ... }:
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
      override = epkgs: epkgs // {
        tsc = epkgs.melpaPackages.tsc.overrideAttrs (oa:
          let
            version = "0.18.0";
            tsc-dyn = fetchurl {
              url = "https://github.com/emacs-tree-sitter/elisp-tree-sitter/releases/download/${version}/tsc-dyn.so";
              sha256 = "sha256-97KDzdYNJN4ceJeuQxZtQ/7iU0CYXEp6gcSM9rNwlyE=";
            };
          in
          {
            postInstall = ''
              cp ${tsc-dyn} $out/share/emacs/site-lisp/elpa/tsc-${oa.version}/tsc-dyn.so
              echo -n ${version} > $out/share/emacs/site-lisp/elpa/tsc-${oa.version}/DYN-VERSION
            '';
          });
        tree-sitter-langs = epkgs.melpaPackages.tree-sitter-langs.overrideAttrs (oa:
          let
            version = "0.11.3";
            tree-sitter-grammars = super.stdenv.mkDerivation rec {
              inherit version;
              name = "tree-sitter-grammars";
              src = fetchzip {
                url = "https://github.com/emacs-tree-sitter/tree-sitter-langs/releases/download/${version}/tree-sitter-grammars-linux-${version}.tar.gz";
                sha256 = "sha256-85Yy6NuEVnibehmalz2qr0pCENYwmxsyyIf0TUYnDY8=";
                stripRoot = false;
              };
              installPhase = ''
                install -d $out/langs/bin
                echo -n "${version}" > $out/langs/bin/BUNDLE-VERSION
                install -m444 * $out/langs/bin
              '';
            };
          in
          {
            src = fetchFromGitHub {
              owner = "emacs-tree-sitter";
              repo = "tree-sitter-langs";
              rev = version;
              sha256 = "sha256-Br+ON7a8FWoU75ySPSP2DkiyHjj80TP5XvcMMJrU9+k=";
            };
            postPatch = ''
              substituteInPlace ./tree-sitter-langs-build.el \
              --replace "tree-sitter-langs-grammar-dir tree-sitter-langs--dir"  "tree-sitter-langs-grammar-dir \"${tree-sitter-grammars}/langs\""
            '';
          });
        gruvbox-theme = epkgs.melpaPackages.gruvbox-theme.overrideAttrs (_: { patches = [ ./gruvbox-el.patch ]; });
      };
    };
  };
}


