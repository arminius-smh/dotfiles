{
  config,
  pkgs,
  ...
}: {
  enable = true;
  package = pkgs.fabricServers.fabric-1_21_1;
  serverProperties = {
    white-list = true;
    difficulty = "hard";
    enable-rcon = true;
    "rcon.password" = config.secrets.minecraft.rcon-pw;
  };
  whitelist = config.secrets.minecraft.whitelist;
  symlinks = {
    "ops.json" = pkgs.writeTextFile {
      name = "ops.json";
      text = config.secrets.minecraft.ops;
    };
    mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
      # https://modrinth.com/mod/sodium
      Sodium = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/AANobbMI/versions/RncWhTxD/sodium-fabric-0.5.11+mc1.21.jar";
        sha256 = "0dxay7rgd126g1imc1wc6ywbcya55zsyyd3p8mkq1ll1j0zpiw9v";
      };
      # https://modrinth.com/mod/lithium
      Lithium = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/5szYtenV/lithium-fabric-mc1.21.1-0.13.0.jar";
        sha256 = "0q8dj7j2z7s6y41idq665p62ni2n9k2n7n72w4307gwpwgz73lqh";
      };
      # https://modrinth.com/mod/ferrite-core
      Ferrit-Core = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/uXXizFIs/versions/wmIZ4wP4/ferritecore-7.0.0-fabric.jar";
        sha256 = "08q3cs3z97i4z3f4idf4c3hf2dh640wksk6wbv7s7rjx3w6j0c9c";
      };
      # https://modrinth.com/mod/fabric-api
      Fabric-API = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/gQS3JbZO/fabric-api-0.103.0+1.21.1.jar";
        sha256 = "0ki3m03bkxqsfyq8v93y8g9d29fjcndpbb7sfm28q8n0zpl2dxld";
      };
      # https://modrinth.com/mod/collective
      Serilum-Collective = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/e0M1UDsY/versions/13do3Fe4/collective-1.21.1-7.84.jar";
        sha256 = "0yrm6z06ms14y401p81dg2wxidq04k9qzzs78xd80d4j34jm0v8j";
      };
      # https://modrinth.com/mod/villager-names-serilum
      Serilum-VillagerNames = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/gqRXDo8B/versions/WPsLTKwG/villagernames-1.21.1-8.1.jar";
        sha256 = "1klnyr58bc3a657yrim3dlp0ljwhwqnz2rpk3iwwsiyrpmc040j5";
      };
      # https://modrinth.com/mod/double-doors
      Serilum-DoubleDoors = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/JrvR9OHr/versions/r73PhzrG/doubledoors-1.21.1-5.9.jar";
        sha256 = "1vbhg1yjj9h8pkzagvcz4hv3bk66i2lzgzl8sbq7rm4gfsmh3dwl";
      };
      # https://modrinth.com/mod/netherportalfix
      Netherportalfix = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nPZr02ET/versions/KtMN6zDF/netherportalfix-fabric-1.21.1-21.1.1.jar";
        sha256 = "07d0pfa0j7px8mck0ds4745xck0ar6cmww5hmlywj16vhbvdmp5b";
      };
      # https://modrinth.com/mod/balm
      Balm = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/MBAkmtvl/versions/jVeu9BFB/balm-fabric-1.21.1-21.0.19.jar";
        sha256 = "0rydpnd7a6722qlmwijh83hl8va2vj9f9l9ygnyr9vc4ivq0njaf";
      };
    });
  };
}
