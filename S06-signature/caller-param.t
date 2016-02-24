use v6.c;
use Test;
plan 7;

sub callerunderscore ($foo = $CALLER::_) {
    return "-" ~ $foo ~ "-"
}

# These tests all work when using CALLER::CALLER but we should
# not need to do that.  Minus that fact, 123660 has actually been
# fixed since it was reported.

is(callerunderscore("foo"), "-foo-", 'CALLER:: string arg');
is(callerunderscore(1), "-1-", 'CALLER:: number arg');
$_ = "foo";
#?rakudo todo "NYI RT #124924"
is(callerunderscore(), "-foo-", 'CALLER:: $_ set once');
$_ = "bar";
#?rakudo todo "NYI RT #124924"
is(callerunderscore(), "-bar-", 'CALLER:: $_ set twice');
for ("quux") {
    #?rakudo todo "NYI RT #123660"
    is(callerunderscore(), '-quux-', 'CALLER:: $_ set by for');
}
given 'hirgel' {
    #?rakudo todo "NYI RT #123660"
    is callerunderscore, '-hirgel-', '$CALLER::_ set by given';
}
#?rakudo todo "NYI RT #124924"
is(callerunderscore(), '-bar-', 'CALLER:: $_ reset after for');


# vim: ft=perl6
