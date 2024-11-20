{
  description = "flake for distributing imperium";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.default = import nixpkgs {
      inherit (nixpkgs) system;
    }.stdenv.mkDerivation {
      pname = "imperium";
      version = "0.1.0";

      src = fetchurl {
        url = "https://github.com/scipo-code/ordinator-imperium-cli.releases/download/v0.1.0/imperium-1.0.0.tar.gz";
        sha = "";
      };

      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/imperium
        chmod +x $out/bin/imperium
      '';
      
    };

  };
}
