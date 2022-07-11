{ emacsWithPackagesFromUsePackage
, stdenv
, fetchzip
, fetchurl
, fetchFromGitHub
, emacsNativeComp
, conf ? null
, ...
}:

assert (conf != null);

emacsWithPackagesFromUsePackage {
  config = conf;
  package = emacsNativeComp;
  alwaysEnsure = true;
  alwaysTangle = true;
  extraEmacsPackages = epkgs: with epkgs; [
    use-package
 #   (epkgs.tree-sitter-langs.withPlugins (_: epkgs.tree-sitter-langs.plugins))
  ];
}
