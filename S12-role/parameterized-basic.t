use v6;

use Test;

plan 3;

=begin pod

Basic parameterized role tests, see L<S12/Roles>

=end pod

#?pugs emit skip_rest('parameterized roles'); exit;
#?pugs emit =begin SKIP

# L<S12/Roles/to be considered part of the long name:>

role AritySelection {
    method x { 1 }
}
role AritySelection[$x] {
    method x { 2 }
}
role AritySelection[$x, $y] {
    method x { 3 }
}

class AS_1 does AritySelection {
}
class AS_2 does AritySelection[1] {
}
class AS_3 does AritySelection[1, 2] {
}
is(AS_1.new.x, 1, 'arity-based selection of role with no parameters');
is(AS_2.new.x, 2, 'arity-based selection of role with 1 parameter');
is(AS_3.new.x, 3, 'arity-based selection of role with 2 parameters');

#?pugs emit =end SKIP

# vim: ft=perl6
