use v6;

use Test;

plan 1;

my $foo = 42;
with 0 -> $pos {
    $foo = $pos;
}
orwith 1 -> $pos {
    $foo = $pos;
}
else {
    $foo = "bar";
}
#?rakudo todo 'with semantics not yet fully implemented'
is $foo, 0, 'with on a false defined value triggers';

# vim: ft=perl6
