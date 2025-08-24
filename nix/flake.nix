{
  description = "UNITN BSc DevPack toolchain";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }:
  let
    forAll = f: nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system:
      f (import nixpkgs { inherit system; }));
  in {
    packages = forAll (pkgs: {
      devpack = pkgs.buildEnv {
        name = "unitn-bsc-devpack";
        paths = (import ./packages.nix { inherit pkgs; });
      };
    });
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.devpack;
  };
}