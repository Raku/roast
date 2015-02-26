no strict;
use Test;
plan 6;

# L<S02/"Names"/"When \"strict\" is in effect (which is the default except for one-liners)">

$baz = 'lax';
is $baz, 'lax', 'variable gets auto-declared when strict is turned off';

class Foo {
    $foo = 42;
    is $foo, 42, 'variable gets auto-declared in packages';
}

is $Foo::foo, 42, 'lax declared variable is package scoped';

{
    use strict;
    throws_like '$foo = 10;', X::Undeclared, suggestions => '';
}

#?rakudo 1 skip 'lax mode does not propagate into EVAL yet'
{
    is EVAL('$bar'), Any, 'lax mode propagates into EVAL blocks'
}

# RT #123696
{
    lives_ok { EVAL '(6;)' },
        '"6;" no longer means "no strict;" and "(6;)" no langer results in a compile time error';
}
