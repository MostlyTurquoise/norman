{ inputs, pkgs, lib, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  programs.java = {
    enable = true;
    package = pkgs.jdk22_headless;
  }; 

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      cartandflynns = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_1;
        serverProperties = {
          white-list=true;
          enforce-whitelist=true;
          view-distance=20;
        };
        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods" (
            builtins.attrValues (
              builtins.mapAttrs (
                name: value: derivation {
                  name = "${name}";
                  system = "x86_64-linux";
                  builder = "${pkgs.coreutils}/bin/cp";
                  args = ["${(builtins.trace "copying from ${value}" value)}" "$out/${name}.jar"];
                }
              ) 
              (import ./mods.nix)
            )
          );
        };
      };
    };
  };
}
