use v6;

use Test;

plan 14;

# L<S05/Substitution/>

my $str = 'hello';

ok $str.match(/h/),         'We can use match';
is $str,  'hello',          '.. it does not do side effect';
ok $str.match(/h/)~~Match,  '.. it returns a Match object';

#?DOES 6
{
    for ('a'..'f') {
        my $r = EVAL("rx/$_/");
        is $str.match($r), $str~~/$r/, ".. works as ~~ matching '$str' with /$_/";
    }
}

# it should work for everything that can be tied to a Str, according to S05
# but possibly it should just be defined in object as an exact alias to ~~ ?

$str = 'food';
my $m = $str.match(/$<x>=[f](o+)/);
ok $m ~~ Match,             'is a Match object';
is $m,    'foo',            'match object stringifies OK';
is $m<x>, 'f',              'match object indexes as a hash';
is $m[0], 'oo',             'match object indexes as an array';

# RT #130953
subtest 'ligatures + case-insensitive match' => {
    plan 5;
    #?rakudo 5 todo 'RT130953'
    is-deeply (for 1..10 { 'ﬆ' x $_ ~ 'T' ~~ m:i/T/ })».Str,
        ('T' xx 10), 'can ~~ m:i/T/';

    is-deeply (for 1..10 { 'ﬆ' x $_ ~ 'T' ~~ /. <( [:i T]/ })».Str,
        ('T' xx 10), 'can ~~ /. <( [:i T]/';

    is-deeply (for 1..10 {  ('ﬆ' x $_ ~ 'T').match: /:i T/ })».Str,
        ('T' xx 10), 'can .match: /:i T/';

    is-deeply (for 1..10 { S:i/T/Z/ with 'ﬆ' x $_ ~ 'T' })».Str,
        (for 1..10 { 'ﬆ' x $_ ~ 'Z' }), 'can S:i/T/Z/';

    is-deeply (for 1..10 { ('ﬆ' x $_ ~ 'T').subst: /:i T/, 'Z' })».Str,
        (for 1..10 { 'ﬆ' x $_ ~ 'Z' }), 'can .subst: /:i T/, "Z"';
}

# vim: ft=perl6
