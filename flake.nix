{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    ruby-nix.url = "github:inscapist/ruby-nix";
    bundix.url = "github:inscapist/bundix/main";
    bundix.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-ruby.url = "github:bobvanderlinden/nixpkgs-ruby";
    nixpkgs-ruby.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      ruby-nix,
      bundix,
      nixpkgs-ruby,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nixpkgs-ruby.overlays.default ];
        };
        rubyNix = ruby-nix.lib pkgs;
        gemset = if builtins.pathExists ./gemset.nix then import ./gemset.nix else { };
        gemConfig = {};
        ruby = pkgs."ruby-3.4.9";
        bundixcli = bundix.packages.${system}.default;
      in
      rec {
        inherit
          (rubyNix {
            inherit gemset ruby;
            name = "my-rails-app";
            gemConfig = pkgs.defaultGemConfig // gemConfig;
          })
          env
          ;
        devShells = rec {
          default = dev;
          dev = pkgs.mkShell {
            buildInputs = [
              env
              bundixcli
            ];
          };
        };
      }
    );
}
