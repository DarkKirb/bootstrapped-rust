{
  description = "Bootstrapped rust";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    rec {
      pkgs = {
        mrustc = pkgs.callPackage ./mrustc { };
        minicargo = pkgs.callPackage ./mrustc/minicargo.nix { };
      };
      hydraJobs = pkgs;
    });
}
