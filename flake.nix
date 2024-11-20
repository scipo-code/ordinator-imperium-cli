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
            version = "0.1.4";

          src = pkgs.fetchurl {
            url = "https://github.com/scipo-code/ordinator-imperium-cli/archive/refs/tags/v0.1.4.tar.gz";
            sha256 = "lOdtCwRBKDuinpsp7Fd5KWYh/s1r6NPkq1bEnZcEpL0";
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
