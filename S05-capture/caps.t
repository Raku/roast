use v6;
use Test;
plan 21;

# L<S05/Match objects/"$/.caps">

sub ca(@x) {
    join '|', gather {
        for @x -> $p {
            take $p.key ~ ':' ~ $p.value;
        }
    }
}

ok 'a b c d' ~~ /(.*)/, 'basic sanity';
isa_ok $/.caps,   List, '$/.caps returns a List';
#?rakudo todo 'return type of .chunks'
isa_ok $/.chunks, List, '$/.chunks returns a List';
isa_ok $/.caps.[0],   Pair, '.. and the items are Pairs (caps);';
isa_ok $/.chunks.[0], Pair, '.. and the items are Pairs (chunks);';
isa_ok $/.caps.[0].value,   Match, '.. and the values are Matches (caps);';
isa_ok $/.chunks.[0].value, Match, '.. and the values are Matches (chunks);';

is ca($/.caps),     '0:a b c d', '$/.caps is one item for (.*)';
is ca($/.chunks),   '0:a b c d', '$/.chunks is one item for (.*)';

my token wc { \w };

ok 'a b c' ~~ /:s <wc=&wc> (\w) <wc=&wc> /, 'regex matches';
is ca($/.caps), 'wc:a|0:b|wc:c', 'named and positional captures mix correctly';
is ca($/.chunks), 'wc:a|~: |0:b|~: |wc:c',
                  'named and positional captures mix correctly (chunks)';

ok 'a b c d' ~~ /[(\w) \s*]+/, 'regex matches';
is ca($/.caps), '0:a|1:b|2:c|3:d', '[(\w)* \s*]+ flattens (...)* for .caps';
is ca($/.chunks), '0:a|~: |1:b|~: |2:c|~: |3:d',
                '[(\w)* \s*]+ flattens (...)* for .chunks';

ok 'a b c d' ~~ /:s [(\w) <wc=&wc> ]+/, 'regex matches';
is ca($/.caps), '0:a|wc:b|1:c|wc:d',
                      'mixed named/positional flattening with quantifiers';
is ca($/.chunks), '0:a|~: |wc:b|~: |1:c|~: |wc:d',
                      'mixed named/positional flattening with quantifiers';

# .caps and .chunks on submatches

ok '  abcdef' ~~ m/.*?(a(.).)/, 'Regex matches';
is ca($0.caps),     '0:b',      '.caps on submatches';
is ca($0.chunks),   '~:a|0:b|~:c',  '.chunks on submatches';

# vim: ft=perl6
