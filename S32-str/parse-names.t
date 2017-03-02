use v6;
use Test;

plan 10 * 2;

for &parse-names, Str.^lookup('parse-names') -> &pn {
    my $t = " ({&pn.^name.lc} form)";

    is-deeply &pn(''), '', "empty tring $t";

    is-deeply &pn(   'BELL'   ), "\c[BELL]", "one char $t";
    is-deeply &pn('   BELL   '), "\c[BELL]",
        "one char with whitespace around it $t";

    is-deeply &pn( 'BELL, BLACK HEART SUIT'   ),  "\c[BELL]♥", "two chars $t";
    is-deeply &pn(' BELL  , BLACK HEART SUIT  '), "\c[BELL]♥",
        "two chars with whitespace around $t";

    throws-like &pn('   BELL,   '           ), X::Str::InvalidCharName,
        'trailing comma';
    throws-like &pn('   ,BELL   '           ), X::Str::InvalidCharName,
        'prefixed comma';
    throws-like &pn('MEOWS PERL6 IS AWESOME'), X::Str::InvalidCharName,
        'unknown name';
    throws-like &pn('MEOWS, BELL'           ), X::Str::InvalidCharName,
        'unknown name + known name';
    throws-like &pn('BELL, MEOWS'           ), X::Str::InvalidCharName,
        'known name + unknown name';
}

# vim: ft=perl6
