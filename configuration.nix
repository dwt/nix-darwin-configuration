{ pkgs, inputs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
    ];

  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = "nix-command flakes";
    bash-prompt-prefix = "(nix:$name)\040";
    substituters = [
      "https://cache.nixos.org"
      "https://cache.lix.systems"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
    ];
    extra-nix-path = "nixpkgs=flake:nixpkgs";
    trusted-users = [
      "root"
      "dwt"
    ];
  };

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
