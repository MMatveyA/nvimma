{
  description = "NeoVim config";

  inputs = {
    nix-systems.url = "github:nix-systems/default";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
    }@inputs:
    let
      defaultOpts = import ./nix/opts.nix;
      eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
      mkPkgs = system: {
        unstable = nixpkgs-unstable.legacyPackages.${system};
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
          overlays = [ (final: prev: (import ./nix/overlays { pkgs = prev; })) ];
        };
      };
    in
    {
      overlays.default = final: prev: { nvimma = self.packages.${prev.system}.default; };
      packages = eachSystem (
        system:
        let
          inherit (mkPkgs system) pkgs unstable;
          inherit (pkgs) callPackage writeShellApplication;
          inherit (pkgs.lib) makeOverridable recursiveUpdate;
          nvimmaOverridable =
            userOpts:
            let
              opts = recursiveUpdate defaultOpts userOpts;
              nvimma = callPackage ./nix/nvimma.nix { inherit pkgs opts; };
            in
            writeShellApplication {
              name = "nvim";
              runtimeInputs = import ./nix/runtime.nix { inherit pkgs unstable opts; };
              text = ''${nvimma}/bin/nvim "$@"'';
            };
        in
        {
          default = makeOverridable nvimmaOverridable defaultOpts;
        }
      );
    };
}
