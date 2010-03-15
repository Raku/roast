use v6;
use Test;

plan *;

=begin pod

=head1 DESCRIPTION

This test tests the C<!...> not metaoperator.

=end pod

is 4 !< 5, !(4 < 5), "4 !< 5";
isa_ok 4 !< 5, Bool, "4 !< 5 is Bool";
is 4 !> 5, !(4 > 5), "4 !> 5";
isa_ok 4 !> 5, Bool, "4 !> 5 is Bool";
is 4 !<= 5, !(4 <= 5), "4 !<= 5";
isa_ok 4 !<= 5, Bool, "4 !<= 5 is Bool";
is 4 !>= 5, !(4 >= 5), "4 !>= 5";
isa_ok 4 !>= 5, Bool, "4 !>= 5 is Bool";
#?rakudo 2 skip "!== is parsed as != ="
is 4 !== 5, !(4 == 5), "4 !== 5";
isa_ok 4 !== 5, Bool, "4 !== 5 is Bool";

is 'bat' !lt 'ace', !('bat' lt 'ace'), "'bat' !lt 'ace'";
isa_ok 'bat' !lt 'ace', Bool, "'bat' !lt 'ace' is Bool";
is 'bat' !gt 'ace', !('bat' gt 'ace'), "'bat' !gt 'ace'";
isa_ok 'bat' !gt 'ace', Bool, "'bat' !gt 'ace' is Bool";
is 'bat' !le 'ace', !('bat' le 'ace'), "'bat' !le 'ace'";
isa_ok 'bat' !le 'ace', Bool, "'bat' !le 'ace' is Bool";
is 'bat' !ge 'ace', !('bat' ge 'ace'), "'bat' !ge 'ace'";
isa_ok 'bat' !ge 'ace', Bool, "'bat' !ge 'ace' is Bool";
is 'bat' !eq 'ace', !('bat' eq 'ace'), "'bat' !eq 'ace'";
isa_ok 'bat' !eq 'ace', Bool, "'bat' !eq 'ace' is Bool";

is 'bat' !before 'ace', !('bat' before 'ace'), "'bat' !before 'ace'";
isa_ok 'bat' !before 'ace', Bool, "'bat' !before 'ace' is Bool";
is 'bat' !after 'ace', !('bat' after 'ace'), "'bat' !after 'ace'";
isa_ok 'bat' !after 'ace', Bool, "'bat' !after 'ace' is Bool";

# !~~ is tested all over the test suite, so we'll skip
# it here.

is 4 !=== 5, !(4 === 5), "4 !=== 5";
isa_ok 4 !=== 5, Bool, "4 !=== 5 is Bool";
is 4 !eqv 5, !(4 eqv 5), "4 !eqv 5";
isa_ok 4 !eqv 5, Bool, "4 !eqv 5 is Bool";
#?rakudo 2 skip "=:= NYI"
is 4 !=:= 5, !(4 =:= 5), "4 !=:= 5";
isa_ok 4 !=:= 5, Bool, "4 !=:= 5 is Bool";


# L<S03/"Negated relational operators"/"allowed for testing even
# divisibility by an integer">
{
    ok 6 !% 3, '6 !% 3';
    isa_ok 6 !% 3, Bool, '6 !% 3 isa Bool';
    nok 6 !% 4, '6 !% 4';
    isa_ok 6 !% 4, Bool, '6 !% 4 isa Bool';

    is (1..10).grep({ $_ !% 3 }), <3 6 9>, '!% works with explicit closure';
    #?rakudo skip "!% does not work with whatever yet"
    is (1..10).grep( * !% 3 ), <3 6 9>, '!% works with whatever *';
}




done_testing;

# vim: ft=perl6
