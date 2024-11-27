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
          mods = pkgs.linkFarmFromDrvs "mods" (builtins.trace (import ./mods.nix) [ (builtins.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/Zp9iAZdZ/fabric-api-0.110.0%2B1.21.1.jar"; sha256 = "145msngqayqw3n0i5fl6lwqdbh91qakllcx43bvp879b3a5hi408"; name = "fabric-api-0.110.02B1.21.1.jar"; }) ]);
        };
      };
    };
  };
}
