{
  description = "flake for distributing imperium";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system: 
      let 
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
            pname = "imperium";
            version = "0.1.3";

          src = pkgs.fetchurl {
            url = "https://github.com/scipo-code/ordinator-imperium-cli/archive/refs/tags/v0.1.3.tar.gz";
            sha256 = "0pks4f58chvjdchy6h3h41w8fnplg9mk19hwf4rbjfs64zvvd1qb";
          };

          installPhase = ''
            mkdir -p $out/bin
            tar -xzf $src
            cp imperium $out/bin        
            chmod +x $out/bin/imperium
          '';

          };
          
        });
}
