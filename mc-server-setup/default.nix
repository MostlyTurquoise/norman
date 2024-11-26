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
          mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            FabricAPI = builtins.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/Zp9iAZdZ/fabric-api-0.110.0%2B1.21.1.jar"; sha256 = "145msngqayqw3n0i5fl6lwqdbh91qakllcx43bvp879b3a5hi408"; };
            AppleSkin = builtins.fetchurl { url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/b5ZiCjAr/appleskin-fabric-mc1.21-3.0.6.jar"; sha256 = ""; };
            _Collective = builtins.fetchurl { url = "https://cdn.modrinth.com/data/e0M1UDsY/versions/nwmUrrgY/collective-1.21.1-7.87.jar"; sha256 = ""; };
            DeathBackup = builtins.fetchurl { url = "https://cdn.modrinth.com/data/Ot5JFxuv/versions/Zq5GkqAd/deathbackup-1.21.1-3.4.jar"; sha256 = ""; };
            ItemRenameOLD = builtins.fetchurl { url = "https://cdn.modrinth.com/data/i5cjb3PQ/versions/qJaQ6MwF/itemrename-1.0.3%2B1.21.jar"; sha256 = ""; };
            Lithium = builtins.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/frXUdgvL/lithium-fabric-0.14.2-snapshot%2Bmc1.21.1-build.90.jar"; sha256 = ""; };
            Spark = builtins.fetchurl { url = "https://cdn.modrinth.com/data/l6YH9Als/versions/cALUj9l1/spark-1.10.109-fabric.jar"; sha256 = ""; };
            SimpleVoiceChat = builtins.fetchurl { url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/Fku4RjPN/voicechat-fabric-1.21.1-2.5.26.jar"; sha256 = ""; };
            Xaero'sMiniMap = builtins.fetchurl { url = "https://cdn.modrinth.com/data/1bokaNcj/versions/C6gFqr7V/Xaeros_Minimap_24.6.1_Fabric_1.21.jar"; sha256 = ""; };
            Xaero'sWorldMap = builtins.fetchurl { url = "https://cdn.modrinth.com/data/NcUtCpym/versions/373K4YJh/XaerosWorldMap_1.39.0_Fabric_1.21.jar"; sha256 = ""; };
          });
        };
      };
    };
  };
}
