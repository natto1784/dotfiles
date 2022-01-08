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
            version = "0.16.1";
            tsc-dyn = fetchurl {
              url = "https://github.com/emacs-tree-sitter/elisp-tree-sitter/releases/download/${version}/tsc-dyn.so";
              sha256 = "sha256-l2mVxnnO43rzLWbOAnX5UZ0a7uk0EPE2x0Jl9rd2D1A=";
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
            version = "0.10.14";
            tree-sitter-grammars = super.stdenv.mkDerivation rec {
              inherit version;
              name = "tree-sitter-grammars";
              src = fetchzip {
                url = "https://github.com/emacs-tree-sitter/tree-sitter-langs/releases/download/${version}/tree-sitter-grammars-linux-${version}.tar.gz";
                sha256 = "sha256-J8VplZWhyWN8ur74Ep0CTl4nPtESzfs2Gh6MxfY5Zqc=";
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
              sha256 = "sha256-uKfkhcm1k2Ov4fSr7ALVnpQoX/l9ssEWMn761pa7Y/c=";
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


