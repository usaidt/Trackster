{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    erlang_27
    elixir_1_18
    inotify-tools
    nodejs_22
    pnpm
  ];

  shellHook = ''
    echo "Elixir version: $(elixir --version | tail -n 1)"
    echo "NodeJS version: $(node -v)"
    echo "Pnpm version: $(pnpm -v)"
  '';
}
