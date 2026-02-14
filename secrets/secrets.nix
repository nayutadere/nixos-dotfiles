let
  nayuta = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPo3fNoSawk3dcSpJZYDG2cy+BSzj9YlVubceBt/Lmdb nayuta@shorekeeper";

  shorekeeper = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKLJYyqOYjdYIDFdsVpleCVXl70bRdIqdYiBIORejG68 root@shorekeeper";

  allAccess = [ nayuta shorekeeper hitori ];
in
{
  "vpn.env.age".publicKeys = allAccess;
  "homepage.env.age".publicKeys = allAccess; 
  "authelia-jwt.age".publicKeys = allAccess;
  "authelia-storage.age".publicKeys = allAccess; 
  "authelia-session.age".publicKeys = allAccess;
  "searxng-secret.age".publicKeys = allAccess;
  "anki-password.age".publicKeys = allAccess;
}
