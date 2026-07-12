let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG03DB31f0FmFf0T4DzNqY5XTlyj+ekmzGmxWvrnIcor";
  users = [ user1 ];

  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICk6OsbQHA7GjL5LL4vQX4nBeHGCwIwsa6GkIn0kkKxR";
  systems = [ system1 ];
in
{
  "sg-sin-wg-001.age".publicKeys = [ user1 system1 ];
}
