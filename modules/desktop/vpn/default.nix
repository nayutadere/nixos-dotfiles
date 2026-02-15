{config, ...}: {

networking.wg-quick.interfaces.wg0 = {
  address = [ "10.164.248.164/32,fd7d:76ee:e68f:a993:d75d:f171:edfe:afcd/128" ];
  dns = [ "10.128.0.1" ];
  privateKey = config.age.secrets.vpn-privateKey.path;

  peers = [
    {
      publicKey = config.age.secrets.vpn-publicKey.path;
      presharedKey = config.age.secrets.vpn-presharedKey.path;
      allowedIPs = [ "0.0.0.0/0" "::/0" ];  # route all traffic
      endpoint = "europe3.vpn.airdns.org:1637"; 
    }
  ];
};
}