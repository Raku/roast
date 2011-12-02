use v6;
use Test;

=begin pod

Matching against an array or a hash.

=end pod

plan 8;

# Matching against an array should be true if any of the values match.
my @a = ('a', 'b' );
ok(@a ~~ / 'b' /);
#?niecza todo
ok(@a ~~ / ^ 'b' /);
ok(@a ~~ / ^ 'a' /);
#?niecza todo
ok(@a ~~ / ^ 'a' $ /);

# Matching against a hash should be true if any of the keys match.
my %a = ('a' => 1, 'b' => 2);
ok(%a ~~ / 'b' /);
#?rakudo todo 'nom regression'
#?niecza todo
ok(%a ~~ / ^ 'b' /);
ok(%a ~~ / ^ 'a' /);
#?rakudo todo 'nom regression'
#?niecza todo
ok(%a ~~ / ^ 'a' $ /);

# vim: ft=perl6
