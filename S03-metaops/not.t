use v6;
use Test;

plan 47;

=begin pod

=head1 DESCRIPTION

This test tests the C<!...> not metaoperator.

=end pod

is 4 !< 5, !(4 < 5), "4 !< 5";
isa-ok 4 !< 5, Bool, "4 !< 5 is Bool";
is 4 !> 5, !(4 > 5), "4 !> 5";
isa-ok 4 !> 5, Bool, "4 !> 5 is Bool";
is 4 !<= 5, !(4 <= 5), "4 !<= 5";
isa-ok 4 !<= 5, Bool, "4 !<= 5 is Bool";
is 4 !>= 5, !(4 >= 5), "4 !>= 5";
isa-ok 4 !>= 5, Bool, "4 !>= 5 is Bool";
is 4 !== 5, !(4 == 5), "4 !== 5";
isa-ok 4 !== 5, Bool, "4 !== 5 is Bool";

is 'bat' !lt 'ace', !('bat' lt 'ace'), "'bat' !lt 'ace'";
isa-ok 'bat' !lt 'ace', Bool, "'bat' !lt 'ace' is Bool";
is 'bat' !gt 'ace', !('bat' gt 'ace'), "'bat' !gt 'ace'";
isa-ok 'bat' !gt 'ace', Bool, "'bat' !gt 'ace' is Bool";
is 'bat' !le 'ace', !('bat' le 'ace'), "'bat' !le 'ace'";
isa-ok 'bat' !le 'ace', Bool, "'bat' !le 'ace' is Bool";
is 'bat' !ge 'ace', !('bat' ge 'ace'), "'bat' !ge 'ace'";
isa-ok 'bat' !ge 'ace', Bool, "'bat' !ge 'ace' is Bool";
is 'bat' !eq 'ace', !('bat' eq 'ace'), "'bat' !eq 'ace'";
isa-ok 'bat' !eq 'ace', Bool, "'bat' !eq 'ace' is Bool";

is 'bat' !before 'ace', !('bat' before 'ace'), "'bat' !before 'ace'";
isa-ok 'bat' !before 'ace', Bool, "'bat' !before 'ace' is Bool";
is 'bat' !after 'ace', !('bat' after 'ace'), "'bat' !after 'ace'";
isa-ok 'bat' !after 'ace', Bool, "'bat' !after 'ace' is Bool";

# !~~ is tested all over the test suite, so we'll skip
# it here.

is 4 !=== 5, !(4 === 5), "4 !=== 5";
isa-ok 4 !=== 5, Bool, "4 !=== 5 is Bool";
is 4 !eqv 5, !(4 eqv 5), "4 !eqv 5";
isa-ok 4 !eqv 5, Bool, "4 !eqv 5 is Bool";
is 4 !=:= 5, !(4 =:= 5), "4 !=:= 5";
isa-ok 4 !=:= 5, Bool, "4 !=:= 5 is Bool";

# Tests based on http://irclog.perlgeek.de/perl6/2012-01-24#i_5045770
# and the next few minutes of log.  --colomon
throws-like '"a" !!eq "a"', X::Syntax::Confused, 'Doubled prefix:<!> is illegal';
ok "a" ![!eq] "a", '![!eq] is legal and works (1)';
nok "a" ![!eq] "b", '![!eq] is legal and works (2)';

# https://github.com/Raku/old-issue-tracker/issues/3252
ok True !&& False, '!&& is legal and works (1)';
nok True !&& True, '!&& is legal and works (2)';
ok False !|| False, '!|| is legal and works (1)';
nok False !|| True, '!|| is legal and works (2)';
ok True !^^ True, '!^^ is legal and works (1)';
nok False !^^ True, '!^^ is legal and works (2)';

throws-like '3 !. foo', X::Syntax::CannotMeta, "!. is too fiddly";
throws-like '3 !. "foo"', X::Obsolete, "!. can't do P5 concat";

is &infix:<!===>(1,2), True, "Meta not can autogen (!===)";
is &infix:<!%%>(3,2), True, "Meta not can autogen (!%%)";
is &infix:<![!%%]>(3,2), False, "Meta not can autogen (![!%%])";
is infix:<!===>(1,2), True, "Meta not can autogen (!===) without &";
is &[!===](1,2), True, "Meta not can autogen (!===) with &[]";

# https://github.com/Raku/old-issue-tracker/issues/4386
subtest 'chaining of !before/!after' => {
    plan 12;

    is-deeply ("a" !after  "b" !after  "c"), True,  '!after/!after (Str)';
    is-deeply ("a" !before "b" !before "c"), False, '!before/!before (Str)';

    #?rakudo 4 skip 'Should this work? https://github.com/rakudo/rakudo/issues/1304'
    is-deeply ("a" !before "b" !after  "c"), False, '!before/!after (Str) (1)';
    is-deeply ("a" !after  "b" !before "c"), False, '!after/!before (Str) (1)';
    is-deeply ("c" !before "a" !after  "b"), True,  '!before/!after (Str) (2)';
    is-deeply ("a" !after  "c" !before "b"), False, '!after/!before (Str) (2)';

    is-deeply (1 !after  2 !after  3), True,  '!after/!after (Int)';
    is-deeply (1 !before 2 !before 3), False, '!before/!before (Int)';

    #?rakudo 4 skip 'Should this work? https://github.com/rakudo/rakudo/issues/1304'
    is-deeply (1 !before 2 !after  3), False, '!before/!after (Int) (1)';
    is-deeply (1 !after  2 !before 3), False, '!after/!before (Int) (1)';
    is-deeply (3 !before 1 !after  2), True,  '!before/!after (Int) (2)';
    is-deeply (1 !after  3 !before 2), False, '!after/!before (Int) (2)';
}

# vim: expandtab shiftwidth=4
