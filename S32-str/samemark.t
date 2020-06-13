use v6;
use Test;

# L<S32::Str/Str/"=item samemark">

plan 9;

#?rakudo.jvm 8 skip 'samemark NYI'
is(samemark('zoo', 'ŏôō'), 'z̆ôō', 'samemark as a function works');
is(samemark('TexT','aSdF'), 'TexT', 'samemark without a change (no accents)');

is('zoo'.samemark('ŏôō'), 'z̆ôō', 'samemark as a method works');
is('text'.samemark('asdf'), 'text', 'samemark without a change (no accents)');

is('z̆ôō'.samemark('ŏôō'), 'z̆ôō', 'samemark without a change (accents already present');
is('ẓo⃥o⃝'.samemark('ŏôō'), 'z̆ôō', 'samemark changes to new accents');

is('tëxt'.samemark('thiș is longer'), 'texț', 'samemark with longer base string');
is('zoö'.samemark('ŏô'), 'z̆ôô', 'samemark with longer source string');

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    #?rakudo.jvm skip 'samemark NYI'
    is "foo".samemark(""), "foo", 'samemark "": nothing to be done';
}

# vim: expandtab shiftwidth=4
