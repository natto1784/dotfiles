{ self, ... }: {
  flake = {
    overlays = rec {
      packages = import ./packages.nix;
      default = packages;
    };
  };

  perSystem = { pkgs, ... }: {
    packages = self.overlays.default null pkgs;
  };
}
