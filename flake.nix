{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
   };
  outputs = { nixpkgs, flake-utils, ... }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        pkgs.default =  system.mkDerivation {
          name = "c_demo";
          src = "./";
          buildPhase = "meson setup build; ninja -C build";
          installPhase = "mkdir -p $out/bin; install -t $out/bin build/c_demo";
        };
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
          openssl
          pkg-config
           gdb
           bashInteractive
            gcc15
            elfutils
            mold
            ccache
            bc
            flex
            bison
            ];
        };
      });


}
