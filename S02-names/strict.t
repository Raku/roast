use v6;
no strict;
use Test;
plan 7;

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
    throws-like '$foo = 10;', X::Undeclared, suggestions => 'Foo';
}

#?rakudo 1 skip 'lax mode does not propagate into EVAL yet'
{
    is EVAL('$bar'), Any, 'lax mode propagates into EVAL blocks'
}

# https://github.com/Raku/old-issue-tracker/issues/3660
{
    lives-ok { EVAL '(6;)' },
        '"6;" no longer means "no strict;" and "(6;)" no longer results in a compile time error';
}

# https://github.com/Raku/old-issue-tracker/issues/4318
subtest '`no strict` does not cause autovivification container issues' => {
    plan 4;

    no strict;
    %h<a> = 42;
    lives-ok { temp %h<b> = 8 },  '`temp` on Hash key';
    lives-ok { let  %h<c> = 9 },  '`let`  on Hash key';
    # https://github.com/Raku/old-issue-tracker/issues/4244
    lives-ok { %h<d><e> }, 'postcircumfix {} on Hash key'; 
    isa-ok %h<non-existent>, Any, 'non-existent keys are `Any`';
}

# vim: expandtab shiftwidth=4
