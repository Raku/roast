use v6;
use Test;
plan 7;

sub callerunderscore ($foo = $CALLER::_) {
    return "-" ~ $foo ~ "-"
}

is(callerunderscore("foo"), "-foo-", 'CALLER:: string arg');
is(callerunderscore(1), "-1-", 'CALLER:: number arg');
$_ = "foo";
#?rakudo todo "NYI"
is(callerunderscore(), "-foo-", 'CALLER:: $_ set once');
$_ = "bar";
#?rakudo todo "NYI"
is(callerunderscore(), "-bar-", 'CALLER:: $_ set twice');
for ("quux") {
    #?rakudo todo "NYI"
    is(callerunderscore(), '-quux-', 'CALLER:: $_ set by for');
}
given 'hirgel' {
    #?rakudo todo "NYI"
    is callerunderscore, '-hirgel-', '$CALLER::_ set by given';
}
#?rakudo todo "NYI"
is(callerunderscore(), '-bar-', 'CALLER:: $_ reset after for');


# vim: ft=perl6
