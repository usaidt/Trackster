{
  description = "Dev shell for Elixir and Phoenix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ...}: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [
        erlang_27
        elixir_1_18
        inotify-tools
        nodejs_23
        pnpm
      ];
  
      shellHook = ''
        echo "Entered the Trackster dev shell"
        echo "Elixir version: $(elixir --version | tail -n 1)"
        echo "NodeJS version: $(node -v)"
        echo "Pnpm version: $(pnpm -v)"
      '';
    };
  };
}
