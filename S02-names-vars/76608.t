use v6;
use Test;
plan 2;

my $y = "foo$(my $x = 42)bar";
ok $x eq 42, "RT #76608 simple assignment";
ok $y eq "foo42bar", "variable interpolation inside string";
