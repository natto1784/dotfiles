{ self, inputs, globalArgs, ... }:
let
  inherit (inputs) nixpkgs;

  commonModules = [
    ./modules/nvim
    globalArgs
  ];
  personalModules = [ ];
  serverModules = [ ./modules/minimal.nix ];
in
{
  flake.nixosConfigurations = {
    #Home laptop
    satori = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ./satori
        { nixpkgs.pkgs = self.legacyPackages.${system}; }
      ]
      ++ personalModules
      ++ commonModules;
    };

    #Home server (RPi4)
    marisa = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";
      modules = [
        ./marisa
        { nixpkgs.pkgs = self.legacyPackages.${system}; }
      ]
      ++ commonModules
      ++ serverModules;
    };

    #Oracle Cloud VM
    remilia = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ./remilia
        ./modules/x86builder.nix
        inputs.mailserver.nixosModules.mailserver
        { nixpkgs.pkgs = self.legacyPackages.${system}; }
      ]
      ++ commonModules
      ++ serverModules;
    };

    #Oracle Cloud VM
    hina = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ./hina
        ./modules/x86builder.nix
        { nixpkgs.pkgs = self.legacyPackages.${system}; }
      ]
      ++ commonModules
      ++ serverModules;
    };
  };
}
