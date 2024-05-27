{ self, ... }: {
  flake = {
    overlays = rec {
      packages = import ./packages.nix;
      default = packages;
    };
  };
}
