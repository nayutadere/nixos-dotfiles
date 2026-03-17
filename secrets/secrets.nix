let
  nayuta_server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPo3fNoSawk3dcSpJZYDG2cy+BSzj9YlVubceBt/Lmdb nayuta@shorekeeper";
  nayuta_desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODzs1Tt3FM4idtNhXmCgun/gMnFlIMONevsUJYhV6f8 nayuta@hitori";

  shorekeeper = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKLJYyqOYjdYIDFdsVpleCVXl70bRdIqdYiBIORejG68 root@shorekeeper";

  hitori = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBB5TP1FncLcob5fkpa+A0GZM3ZtNZO0q1Kr3jYGiRPS root@hitori";

  allAccess = [ nayuta_server nayuta_desktop shorekeeper hitori ];
in
{
  "shorekeeper/vpn.env.age".publicKeys = allAccess;
  "shorekeeper/homepage.env.age".publicKeys = allAccess;
  "shorekeeper/authelia-jwt.age".publicKeys = allAccess;
  "shorekeeper/authelia-storage.age".publicKeys = allAccess;
  "shorekeeper/authelia-session.age".publicKeys = allAccess;
  "shorekeeper/searxng-secret.age".publicKeys = allAccess;
  "shorekeeper/anki-password.age".publicKeys = allAccess;
  "hitori/vpn.privateKey.age".publicKeys = allAccess;
  "hitori/vpn.publicKey.age".publicKeys = allAccess;
  "hitori/vpn.presharedKey.age".publicKeys = allAccess;
  "shorekeeper/neko-env.age".publicKeys = allAccess;
}