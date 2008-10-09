use Test;
plan 8;

# L<S03/"Junctive and (all) precedence"/"infix:<where>">

ok ?(1 where 2),         "basic infix:<where>";
ok ?(1 where 2 where 3), "basic infix:<where> (multiple where's)";
ok !(0 where 1),         "where has and-semantics (first term 0)";
ok !(1 where 0),         "where has and-semantics (second term 0)";

my $x = '';

ok ?('a' ~~ { $x ~= "b" } where { $x ~= "c" }), 'where with two blocks';
is $x, 'bc', 'blocks called in the right order';

my $executed = 0;

ok !('a' ~~ 'b' where { $executed = 1 }), 'and semantics';
ok !$executed,                            'short-circuit';

# vim: ft=perl6
