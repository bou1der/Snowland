
{ pkgs, config, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{
  services.monero = {
    enable = true;
    mining.enable = false;

    rpc = {
      port = 18085;
      user = env "monero/login";
      password = env "monero/password";
    };


    extraConfig = ''
      p2p-bind-ip=0.0.0.0            # Bind to all interfaces (the default)
      p2p-bind-port=18080            # Bind to default port
      #no-igd=1                       # Disable UPnP port mapping

      rpc-restricted-bind-ip=0.0.0.0 
      rpc-restricted-bind-port=18089 

      # RPC TLS
      rpc-ssl=autodetect             # Use TLS if client wallet supports it (Default); A new certificate will be regenerated every restart

      # ZMQ
      #zmq-rpc-bind-ip=127.0.0.1      # Default 127.0.0.1
      #zmq-rpc-bind-port=18082        # Default 18082
      zmq-pub=tcp://127.0.0.1:18083  # ZMQ pub
      #no-zmq=1                       # Disable ZMQ RPC server

      max-txpool-weight=2684354560   

      # Network limits
      out-peers=24              # This will enable much faster sync and tx awareness; the default 8 is suboptimal nowadays
      in-peers=48               # The default is unlimited; we prefer to put a cap on this

    '';
  };
}
