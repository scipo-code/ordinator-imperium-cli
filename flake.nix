{
  description = "flake for distributing imperium";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages = { system, ... }: 
    let
      pkgs = import nixpkgs { inherit system; };
    in {
      default = pkgs.stdenv.mkDerivation {
        pname = "imperium";
        version = "0.1.0";
      

      src = pkgs.fetchurl {
        url = "https://github.com/scipo-code/ordinator-imperium-cli/archive/refs/tags/v0.1.3.tar.gz";
        sha = "";
      };

      installPhase = ''
        mkdir -p $out/bin
        tar -xzf $src -C $out/bin
        chmod +x $out/bin/imperium
      '';
      };
      
    };

  };
}
