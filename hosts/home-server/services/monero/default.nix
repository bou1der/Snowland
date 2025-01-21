
{ pkgs, config, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{
  services.monero = {
    enable = true;
    mining = {
      enable = false;
      threads = 6;
      address = env "monero/address";
    };

    rpc = {
      port = 18085;
      user = env "monero/login";
      password = env "monero/password";
    };

    dataDir = "/mnt/nvme-mount/monero";

    extraConfig = ''
      p2p-bind-ip=0.0.0.0
      p2p-bind-port=18080

      rpc-restricted-bind-ip=0.0.0.0 
      rpc-restricted-bind-port=18089 

      rpc-ssl=autodetect
      db-sync-mode=fast

      zmq-pub=tcp://127.0.0.1:18083                      

      max-txpool-weight=2684354560   

      out-peers=24 
      in-peers=48  
    '';
  };

  services.xmrig = {
    enable = false;
    settings = {
      autosave = true;
      cpu = true;
      opencl = false;
      cuda = true;

      pools = [
        {
          coin = "monero";
          url = "xmr-eu1.nanopool.org:14433";
          user = env "monero/address";
          tls = true;
        }
      ];
    };
  };
}
