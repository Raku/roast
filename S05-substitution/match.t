use v6;

use Test;

plan 13;

# L<S05/Substitution/>

my $str = 'hello';

ok $str.match(/h/),         'We can use match';
is $str,  'hello',          '.. it does not do side effect';
ok $str.match(/h/)~~Match,  '.. it returns a Match object';

#?DOES 6
{
    for ('a'..'f') {
        my $r = eval("rx/$_/");
        is $str.match($r), $str~~$r, ".. works as ~~ matching '$str' with /$_/";
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

# vim: ft=perl6
