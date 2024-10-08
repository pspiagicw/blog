{
  description = "Neovim configuration with stylua";

  inputs = {
    # Nixpkgs repository
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    devShell.x86_64-linux = let
      pkgs = import nixpkgs {system = "x86_64-linux";};
    in
      pkgs.mkShell {
        buildInputs = [
          pkgs.hugo
        ];
      };
    devShell.aarch64-linux = let
      pkgs = import nixpkgs {system = "aarch64-linux";};
    in
      pkgs.mkShell {
        buildInputs = [
          pkgs.hugo
        ];
      };
  };
}
