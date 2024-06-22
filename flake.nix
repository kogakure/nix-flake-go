{
  description = "A simple Go program";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";

  outputs = { self, nixpkgs }: {
    packages = {
      aarch64-darwin = {
        default =
          let
            pkgs = import nixpkgs { system = "aarch64-darwin"; };
          in
          pkgs.stdenv.mkDerivation {
            name = "hello";
            src = ./.;
            buildInputs = [ pkgs.go ];
            buildPhase = ''
              export GOCACHE=$(mktemp -d)
              go build -o hello main.go
            '';
            installPhase = ''
              mkdir -p $out/bin
              install -t $out/bin hello
            '';
          };
      };

      x86_64-linux = {
        default =
          let
            pkgs = import nixpkgs { system = "x86_64-linux"; };
          in
          pkgs.stdenv.mkDerivation {
            name = "hello";
            src = ./.;
            buildInputs = [ pkgs.go ];
            buildPhase = ''
              export GOCACHE=$(mktemp -d)
              go build -o hello main.go
            '';
            installPhase = ''
              mkdir -p $out/bin
              install -t $out/bin hello
            '';
          };
      };
    };
  };
}
