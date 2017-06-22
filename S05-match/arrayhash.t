use v6;
use Test;

=begin pod

Matching against an array or a hash.

=end pod

plan 9;

# Matching against an array should be true if any of the values match.
my @a = ('a', 'b' );
ok(@a ~~ / 'b' /, q|@a ~~ / 'b' /|);
ok(@a ~~ / ^ 'b' /, q|@a ~~ / ^ 'b' /|);
ok(@a ~~ / ^ 'a' /, q|@a ~~ / ^ 'a' /|);
ok(@a ~~ / ^ 'a' $ /, q|@a ~~ / ^ 'a' $ /|);

# Matching against a sequence (possibly infinite)
ok(("a"...* ~~ / z /), q|"a"...* ~~ / z /|);

# Matching against a hash should be true if any of the keys match.
my %a = ('a' => 1, 'b' => 2);
ok(%a ~~ / 'b' /, q|%a ~~ / 'b' /|);
ok(%a ~~ / ^ 'b' /, q|%a ~~ / ^ 'b' /|);
ok(%a ~~ / ^ 'a' /, q|%a ~~ / ^ 'a' /|);
ok(%a ~~ / ^ 'a' $ /, q|%a ~~ / ^ 'a' $ /|);

# vim: ft=perl6
