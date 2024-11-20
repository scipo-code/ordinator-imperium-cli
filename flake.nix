{
  description = "flake for distributing imperium";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
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
            version = "0.1.5";

          src = pkgs.fetchurl {
            url = "https://github.com/scipo-code/ordinator-imperium-cli/archive/refs/tags/v0.1.5.tar.gz";
            sha256 = "11d1b1ccgamzjybm1fcprk3qx04ij3smypfpsaf0wxb75c6chx4k";
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
