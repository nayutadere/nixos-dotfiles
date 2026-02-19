let
  nayuta_server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPo3fNoSawk3dcSpJZYDG2cy+BSzj9YlVubceBt/Lmdb nayuta@shorekeeper";
  nayuta_desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODzs1Tt3FM4idtNhXmCgun/gMnFlIMONevsUJYhV6f8 nayuta@hitori";

  shorekeeper = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKLJYyqOYjdYIDFdsVpleCVXl70bRdIqdYiBIORejG68 root@shorekeeper";

  hitori = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBB5TP1FncLcob5fkpa+A0GZM3ZtNZO0q1Kr3jYGiRPS root@hitori";

  allAccess = [ nayuta_server nayuta_desktop shorekeeper hitori ];
in
{
  "vpn.env.age".publicKeys = allAccess;
  "homepage.env.age".publicKeys = allAccess;
  "authelia-jwt.age".publicKeys = allAccess;
  "authelia-storage.age".publicKeys = allAccess;
  "authelia-session.age".publicKeys = allAccess;
  "searxng-secret.age".publicKeys = allAccess;
  "anki-password.age".publicKeys = allAccess;
  "vpn.privateKey.age".publicKeys = allAccess;
  "vpn.publicKey.age".publicKeys = allAccess;
  "vpn.presharedKey.age".publicKeys = allAccess;
}