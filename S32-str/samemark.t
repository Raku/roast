use v6;
use Test;

# L<S32::Str/Str/"=item samemark">

plan 9;

#?rakudo.jvm 8 skip 'samemark NYI'
is(samemark('zoo', 'ŏôō'), 'z̆ôō', 'samemark as a function works');
is(samemark('TexT','aSdF'), 'TexT', 'samemark without a change (no accents)');

is('zoo'.samemark('ŏôō'), 'z̆ôō', 'samemark as a method works');
is('text'.samemark('asdf'), 'text', 'samemark without a change (no accents)');

is('z̆ôō'.samemark('ŏôō'), 'z̆ôō', 'samemark without a change (accents already present');
is('ẓo⃥o⃝'.samemark('ŏôō'), 'z̆ôō', 'samemark changes to new accents');

is('tëxt'.samemark('thiș is longer'), 'texț', 'samemark with longer base string');
is('zoö'.samemark('ŏô'), 'z̆ôô', 'samemark with longer source string');

# RT #128615 RT #128662
{
    #?rakudo.jvm skip 'samemark NYI'
    is "foo".samemark(""), "foo", 'samemark "": nothing to be done';
}
# perl6/problem-solving#61
#?rakudo.jvm 3 skip 'samemark NYI'
{
    is ‘🇦🇬’.samemark('é').ords, '127462 127468 769';

    is "\c[arabic number sign]a".samemark('é').NFD.list, '97 769', 'prepend test';
    is "a".samemark("\c[arabic number sign]é").NFD.list,
      "\c[arabic number sign]".ord ~ ' 97 769', 'prepend test';
}

# vim: ft=perl6
