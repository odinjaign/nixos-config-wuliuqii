{ pkgs, ... }:
{
  imports = [
    ./go.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    # lsp
    # nil
    nixpkgs-fmt
    nil

    # markdown
    marksman
  ];
}
