use v6;
use Test;

plan 33;

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
is 4 !=:= 5, !(4 =:= 5), "4 !=:= 5";
isa_ok 4 !=:= 5, Bool, "4 !=:= 5 is Bool";

# Tests based on http://irclog.perlgeek.de/perl6/2012-01-24#i_5045770
# and the next few minutes of log.  --colomon

#?rakudo todo 'unknown'
eval_dies_ok '"a" !!eq "a"', 'Doubled prefix:<!> is illegal';
ok "a" ![!eq] "a", '![!eq] is legal and works (1)';
nok "a" ![!eq] "b", '![!eq] is legal and works (2)';

done;

# vim: ft=perl6
