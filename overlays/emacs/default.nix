{ emacsWithPackagesFromUsePackage
, stdenv
, fetchzip
, fetchurl
, fetchFromGitHub
, emacsNativeComp
, config ? null
, package ? emacsNativeComp
, ...
}:

assert (config != null);

emacsWithPackagesFromUsePackage {
  inherit config package;
  alwaysEnsure = true;
  alwaysTangle = true;
  extraEmacsPackages = epkgs: with epkgs; [
    use-package
    (epkgs.tree-sitter-langs.withPlugins (_: epkgs.tree-sitter-langs.plugins))
  ];
}
