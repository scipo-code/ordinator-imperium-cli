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
            version = "0.1.10";

          src1 = pkgs.fetchurl {
            url = "https://github.com/scipo-code/ordinator-imperium-cli/releases/download/v0.1.10/imperium.exe";
            sha256 = "164gasn0sg6z4wdnb1zw5hqd5zn49cp1hr1c4sir9ifyn9qv6wi5";
          };

          src= pkgs.fetchurl {
            url = "https://github.com/scipo-code/ordinator-imperium-cli/releases/download/v0.1.10/imperium";
            sha256 = "060b6ky1h2h8r5fjs0897lwqrql5j7ykkfq83fpjg57cijkyy3jk";
          };

          unpackPhase = ":";

          installPhase = ''
            mkdir -p $out/bin
            # cp imperium.exe $out/bin        
            cp imperium $out/bin        
            # chmod +x $out/bin/imperium.exe
            chmod +x $out/bin/imperium
          '';
          };
        });
}
