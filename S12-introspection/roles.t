use v6;

use Test;

plan 12;

=begin pod

Tests for .^roles from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"list of roles">

role R1 { }
role R2 { }
role R3 { }
class C1 does R1 does R2 { }
class C2 is C1 does R3 { }

my @roles = C2.^roles(:local);
is +@roles,   1,  ':local returned list with correct number of roles';
is @roles[0], R3, 'role in list was correct';

@roles = C1.^roles(:local);
is +@roles,   2,  ':local returned list with correct number of roles';
ok (@roles[0] ~~ R1 && @roles[1] ~~ R2 || @roles[0] ~~ R2 && @roles[1] ~~ R1),
                  'roles in list were correct';

ok C2.^roles ~~ Positional, '.^roles returns something Positional';
@roles = C2.^roles();
is +@roles,   3,  'with no args returned list with correct number of roles';
is @roles[0], R3, 'first role in list was correct';
ok (@roles[1] ~~ R1 && @roles[2] ~~ R2 || @roles[1] ~~ R2 && @roles[2] ~~ R1),
                  'second and third roles in list were correct';
#?rakudo skip '.^roles(:tree)'
{
@roles = C2.^roles(:tree);
is +@roles,   2,       ':tree returned list with correct number of elements';
is @roles[0], R3,      'first element in the list is the role done in base class';
ok @roles[1] ~~ Array, 'second element in list is an array';
ok @roles[1][0] ~~ R1 && @roles[1][1] ~~ R2 || @roles[1][0] ~~ R2 && @roles[1][1] ~~ R1,
                       'nested array contains roles of parent class';
}

# vim: ft=perl6
