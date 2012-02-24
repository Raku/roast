use v6;
use Test;
plan 14;

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

my $root = "mkdir-t-testfile-" ~ 1000000.rand.floor;

say $root;

nok $root.IO ~~ :e, "$root does not currently exist";

ok mkdir($root), "mkdir $root returns true";
ok $root.IO ~~ :e, "$root now exists";
ok $root.IO ~~ :d, "... and is a directory";

ok mkdir("$root/green"), "mkdir $root/green returns true";
ok "$root/green".IO ~~ :e, "$root/green now exists";
ok "$root/green".IO ~~ :d, "... and is a directory";

nok rmdir($root), "Get false when we try to rmdir a directory with something in it";
ok $root.IO ~~ :e, "$root still exists";

ok rmdir("$root/green"), "Can remove $root/green";
nok "$root/green".IO ~~ :e, "$root/green no longer exists";
ok $root.IO ~~ :e, "$root still exists";

ok rmdir("$root"), "Can remove $root now";
nok $root.IO ~~ :e, "$root no longer exists";


