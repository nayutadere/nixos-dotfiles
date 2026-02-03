let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPo3fNoSawk3dcSpJZYDG2cy+BSzj9YlVubceBt/Lmdb nayuta@shorekeeper";
  users = [ user1 ];

  shorekeeper = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKLJYyqOYjdYIDFdsVpleCVXl70bRdIqdYiBIORejG68 root@shorekeeper";
in
{
  "vpn.env.age".publicKeys = users ++ [ shorekeeper ];
  "homepage.env.age".publicKeys = users ++ [ shorekeeper ];
  "authelia-jwt.age".publicKeys     = users ++ [ shorekeeper ];
  "authelia-storage.age".publicKeys = users ++ [ shorekeeper ];
  "authelia-session.age".publicKeys = users ++ [ shorekeeper ];
}