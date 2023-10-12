{
  description = "PlanetScale simulator for local testing and development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            go
            gopls
          ];
        };

        packages.default = pkgs.buildGoModule {
          name = "ps-http-sim";
          src = ./.;
          vendorHash = "sha256-rKy8RStimcj7DHRVeZiAHEGtkEvU2JdFj9RcYicFsUg=";
        };
      });
}
