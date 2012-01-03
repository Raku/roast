use v6;
use Test;
plan 7;

sub callerunderscore ($foo = $CALLER::_) {
    return "-" ~ $foo ~ "-"
}

is(callerunderscore("foo"), "-foo-", 'CALLER:: string arg');
is(callerunderscore(1), "-1-", 'CALLER:: number arg');
$_ = "foo";
#?niecza todo 'System.Exception: Improper null return from sub default for $foo = $CALLER::_ in MAIN callerunderscore'
is(callerunderscore(), "-foo-", 'CALLER:: $_ set once');
$_ = "bar";
#?niecza todo 'System.Exception: Improper null return from sub default for $foo = $CALLER::_ in MAIN callerunderscore'
is(callerunderscore(), "-bar-", 'CALLER:: $_ set twice');
for ("quux") {
    #?niecza todo 'System.Exception: Improper null return from sub default for $foo = $CALLER::_ in MAIN callerunderscore'
    is(callerunderscore(), '-quux-', 'CALLER:: $_ set by for');
}
given 'hirgel' {
    #?niecza todo 'System.Exception: Improper null return from sub default for $foo = $CALLER::_ in MAIN callerunderscore'
    is callerunderscore, '-hirgel-', '$CALLER::_ set by given';
}
#?niecza todo 'System.Exception: Improper null return from sub default for $foo = $CALLER::_ in MAIN callerunderscore'
is(callerunderscore(), '-bar-', 'CALLER:: $_ reset after for');


# vim: ft=perl6
