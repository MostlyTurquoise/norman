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
    openFirewall = true;

    servers = {
      cartandflynns = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_1;
        jvmOpts = "-Xms4144M -Xmx6192M";
        serverProperties = (import ./cartandflynns/server.properties.nix);
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
              (import ./cartandflynns/mods.nix)
            )
          );
        };
      };
      puttheleeinholly = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_6;
        jvmOpts = "-Xms4144M -Xmx6192M";
        serverProperties = (import ./puttheleeinholly/server.properties.nix);
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
              (import ./puttheleeinholly/mods.nix)
            )
          );
        };
      };
    };
  };
}
