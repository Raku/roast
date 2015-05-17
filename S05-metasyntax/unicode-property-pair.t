use v6;
use Test;

plan 5;

# L<S05/Extensible metasyntax (C<< <...> >>)/Unicode properties are indicated by use of pair notation>

# Boolean properties
is '.a-' ~~ /<:Letter>/, 'a', 'a letter';
is '.a-' ~~ /<:!Letter>/, '.', 'a non-letter';

#?rakudo.jvm 3 skip 'matching charnames in unicode property pair'
# Properties with arguments are passed as the argument to the pair:
is 'flubber¼½worms' ~~ /<:NumericValue(0 ^..^ 1)>+/, '¼½', 'the char has a proper fractional value';

# As a particular case of smartmatching, TR18 section 2.6 is satisfied with a pattern as the argument:
is 'FooBar' ~~ /<:name(/:s LATIN SMALL LETTER/)>+/,   'oo', 'match character names';
is 'FooBar' ~~ /<:Name(/:s LATIN CAPITAL LETTER/)>+/, 'F',  'match character names';

# Multiple of these terms may be combined with pluses and minuses:
# XXX e.g. <+ :HexDigit - :Upper >
