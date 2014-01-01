use v6;

use Test;

plan 13;

# L<S05/Substitution/>

my $str = 'hello';

#?pugs todo
ok $str.match(/h/),         'We can use match';
is $str,  'hello',          '.. it does not do side effect';
ok $str.match(/h/)~~Match,  '.. it returns a Match object';

#?DOES 6
{
    for ('a'..'f') {
        my $r = EVAL("rx/$_/");
        is $str.match($r), $str~~$r, ".. works as ~~ matching '$str' with /$_/";
    }
}

# it should work for everything that can be tied to a Str, according to S05
# but possibly it should just be defined in object as an exact alias to ~~ ?

$str = 'food';
my $m = $str.match(/$<x>=[f](o+)/);
ok $m ~~ Match,             'is a Match object';
#?pugs todo
is $m,    'foo',            'match object stringifies OK';
#?pugs todo
is $m<x>, 'f',              'match object indexes as a hash';
#?pugs todo
is $m[0], 'oo',             'match object indexes as an array';

# vim: ft=perl6
