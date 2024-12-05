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
            sha256 = "Uw7vp4zslCevGwi7Of2RheKMOT0JAS1dyQgKGPw0Cxg=";
          };

          src2= pkgs.fetchurl {
            url = "https://github.com/scipo-code/ordinator-imperium-cli/releases/download/v0.1.10/imperium";
            sha256 = "11d1b1ccgamzjybm1fcprk3qx04ij3smypfpsaf0wxb75c6chx4k";
          };

          installPhase = ''
            mkdir -p $out/bin
            cp imperium.exe $out/bin        
            cp imperium $out/bin        
            chmod +x $out/bin/imperium.exe
            chmod +x $out/bin/imperium
          '';
          };
        });
}
