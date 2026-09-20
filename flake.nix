{
  description = "badkeys";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      nixpkgs,
      ...
    }:
    {
      formatter = builtins.mapAttrs (system: pkgs: pkgs.nixfmt-tree) nixpkgs.legacyPackages;

      packages = builtins.mapAttrs (system: pkgs: {
        default = pkgs.python3Packages.callPackage ./nix/package.nix { };
      }) nixpkgs.legacyPackages;

      devShells = builtins.mapAttrs (system: pkgs: {
        default = pkgs.mkShell {
          packages = [
            (pkgs.python3.withPackages (
              python-pkgs: with python-pkgs; [
                cryptography
                gmpy2
                paramiko
              ]
            ))
          ];
        };
      }) nixpkgs.legacyPackages;
    };
}
