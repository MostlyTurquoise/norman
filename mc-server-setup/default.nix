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

    user = "server";

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
                  name = "${name}.jar";
                  system = "x86_64-linux";
                  builder = "${pkgs.bash}/bin/bash";
                  args = ["-c" "${pkgs.coreutils}/bin/touch $out && ${pkgs.coreutils}/bin/cp ${(builtins.trace "copying from ${value}" value)} $out"];
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
