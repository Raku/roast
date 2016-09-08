use v6;

use Test;

plan 1;

{
    is-deeply Any.pairup(), (), 'pairup on an undefined invocant returns an empty list'
}

# vim: ft=perl6
