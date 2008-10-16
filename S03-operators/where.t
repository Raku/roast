use Test;
plan 8;

# L<S03/"Junctive and (all) precedence"/"infix:<also>">

ok ?(1 also 2),         "basic infix:<also>";
ok ?(1 also 2 also 3), "basic infix:<also> (multiple also's)";
ok !(0 also 1),         "also has and-semantics (first term 0)";
ok !(1 also 0),         "also has and-semantics (second term 0)";

my $x = '';

ok ?('a' ~~ { $x ~= "b"; True } also { $x ~= "c"; True }), 'also with two blocks';
is $x, 'bc', 'blocks called in the right order';

my $executed = 0;

ok !('a' ~~ 'b' also { $executed = 1; True }), 'and semantics';
ok !$executed,                            'short-circuit';

# vim: ft=perl6
