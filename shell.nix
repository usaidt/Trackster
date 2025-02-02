{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [
    pkgs.dotnet-sdk_9
  ];

  shellHook = ''
    echo "ASP .NET Core development environment"
    
    echo "NET version..."
    dotnet --version

  '';
}
