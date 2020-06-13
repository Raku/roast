use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 10 * 4;

# `uniparse` Tests. Note `parse-names` is the original "experimental" name
# of this routine. It issues deprecation warning in Rakudo in 6.d and will
# be removed in 6.e. Other implementations may wish to restructure these
# tests and not implement `parse-names` at all.

for &parse-names, Str.^lookup('parse-names'),
    &uniparse,    Str.^lookup('uniparse') -> &pn
{
    my $t = " ({&pn.^name.lc} form)";

    is-deeply &pn(''), '', "empty string $t";

    is-deeply &pn(   'BELL'   ), "\c[BELL]", "one char $t";
    is-deeply &pn('   BELL   '), "\c[BELL]",
        "one char with whitespace around it $t";

    is-deeply &pn( 'BELL, BLACK HEART SUIT'   ),  "\c[BELL]♥", "two chars $t";
    is-deeply &pn(' BELL  , BLACK HEART SUIT  '), "\c[BELL]♥",
        "two chars with whitespace around $t";

    fails-like { &pn('   BELL,   '           ) }, X::Str::InvalidCharName,
        'trailing comma';
    fails-like { &pn('   ,BELL   '           ) }, X::Str::InvalidCharName,
        'prefixed comma';
    fails-like { &pn('MEOWS PERL6 IS AWESOME') }, X::Str::InvalidCharName,
        'unknown name';
    fails-like { &pn('MEOWS, BELL'           ) }, X::Str::InvalidCharName,
        'unknown name + known name';
    fails-like { &pn('BELL, MEOWS'           ) }, X::Str::InvalidCharName,
        'known name + unknown name';
}

# vim: expandtab shiftwidth=4
