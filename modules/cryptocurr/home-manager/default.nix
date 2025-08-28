{ pkgs, ... }:
{
  # home-manager options
  home = {
    packages = with pkgs; [
      trezor-suite # manage crypto

      monero-cli # monero daemon
      monero-gui # monero wallet
      xmrig # monero miner
      p2pool # monero decentralized mining pool
    ];
  };
}
