{
  description = "A simple Go program";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "aarch64-darwin" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: import nixpkgs { inherit system; };
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.stdenv.mkDerivation {
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
        });
    };
}
