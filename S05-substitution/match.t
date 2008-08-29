use v6;

use Test;

plan 9;

# L<S05/Substitution/>

my $str = 'hello';


ok $str.match(/h/),         'We can use match';
is $str,  'hello',          '.. it does not do side effect';
#?rakudo skip 'return Match object, RT #57094'
ok $str.match(/h/)~~Match,  '.. it returns a Match object';

#?rakudo skip 'Null PMC access in can()'
#?DOES 6
{
    for ('a'..'f') {
        my $r = eval("rx/$_/");
        is $str.match($r), $str~~$r, ".. works as ~~ matching '$str' with /$_/";
    }
}

# it should work for everything that can be tied to a Str, according to S05
# but possibly it should just be defined in object as an exact alias to ~~ ?

