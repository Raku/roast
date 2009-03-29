use v6;
use Test;
plan 18;

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
#?rakudo skip '%($/).pairs stringifies Match'
isa_ok $/.chunks, List, '$/.chunks returns a List';
isa_ok $/.caps.[0],   Pair, '.. and the items are Pairs (caps);';
#?rakudo skip '%($/).pairs stringifies Match'
isa_ok $/.chunks.[0], Pair, '.. and the items are Pairs (chunks);';
#?rakudo todo '%($/).pairs stringifies Match'
isa_ok $/.caps.[0].value,   Match, '.. and the items are Matches (caps);';
#?rakudo skip '%($/).pairs stringifies Match'
isa_ok $/.chunks.[0].value, Match, '.. and the items are Matches (chunks);';

is ca($/.caps),     '0:a b c d', '$/.caps is one item for (.*)';
#?rakudo skip 'Match.chunks'
is ca($/.chunks),   '0:a b c d', '$/.chunks is one item for (.*)';

token wc { \w };

ok 'a b c' ~~ /:s <wc> (\w) <wc> /, 'regex matches';
#?rakudo 2 skip '%($/).pairs stringifies Match'
is ca($/.caps), 'wc:a|0:b|wc:c', 'named and positional captures mix correctly';
is ca($/.chunks), '~: |wc:a|~: |0:b|~: |wc:c',
                  'named and positional captures mix correctly (chunks)';

ok 'a b c d' ~~ /[(\w) \s*]+/, 'regex matches';
#?rakudo 2 skip '%($/).pairs stringifies Match'
is ca($/.caps), '0:a|0:b|0:c|0:d', '[(\w)* \s*]+ flattens (...)* for .caps';
is ca($/.chunks), '0:a|~: |0:b|~: |0:c|~: |0:d',
                '[(\w)* \s*]+ flattens (...)* for .chunks';

ok 'a b c d' ~~ /:s [(\w) <wc> ]+/, 'regex matches';
#?rakudo 2 skip '%($/).pairs stringifies Match'
is ca($/.caps), '0:a|wc:b|0:c|wc:d', 
                      'mixed named/positional flattening with quantifiers';
is ca($/.chunks), '0:a|~: |wc:b|~: |0:c|~: |wc:d', 
                      'mixed named/positional flattening with quantifiers';

# vim: ft=perl6
