use v6;
use Test;
plan 42;

# L<S05/Match objects/"$/.caps">

sub ca(@x) {
    join '|', gather {
        for @x -> $p {
            take $p.key ~ ':' ~ $p.value;
        }
    }
}

ok 'a b c d' ~~ /(.*)/, 'basic sanity';
ok $/.caps ~~ Positional, '$/.caps returns something Positional';
ok $/.chunks ~~ Positional, '$/.chunks returns something Positional';
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
is ca($/.caps), '0:a|0:b|0:c|0:d', '[(\w)* \s*]+ flattens (...)* for .caps';
is ca($/.chunks), '0:a|~: |0:b|~: |0:c|~: |0:d',
                '[(\w)* \s*]+ flattens (...)* for .chunks';

ok 'a b c' ~~ /[ (\S) \s ] ** 2 (\S)/, 'regex matches';
is ca($/.caps), '0:a|0:b|1:c', '.caps distinguishes quantified () and multiple ()';
is ca($/.chunks), '0:a|~: |0:b|~: |1:c', '.chunks distinguishes quantified () and multiple ()';

ok 'a b c d' ~~ /:s [(\w) <wc=&wc> ]+/, 'regex matches';
#'RT 75484 (fails randomly) (noauto)'
is ca($/.caps), '0:a|wc:b|0:c|wc:d',
                      'mixed named/positional flattening with quantifiers';
is ca($/.chunks), '0:a|~: |wc:b|~: |0:c|~: |wc:d',
                      'mixed named/positional flattening with quantifiers';

# .caps and .chunks on submatches

ok '  abcdef' ~~ m/.*?(a(.).)/, 'Regex matches';
is ca($0.caps),     '0:b',      '.caps on submatches';
is ca($0.chunks),   '~:a|0:b|~:c',  '.chunks on submatches';

# RT #117831 separator captures
ok 'a;b,c,' ~~ m/(<.alpha>) +% (<.punct>)/, 'Regex matches';
is ca($/.caps),     '0:a|1:;|0:b|1:,|0:c',  '.caps on % separator';
is ca($/.chunks),   '0:a|1:;|0:b|1:,|0:c',  '.chunks on % separator';

ok 'a;b,c,' ~~ m/(<.alpha>) +%% (<.punct>)/, 'Regex matches';
is ca($/.caps),     '0:a|1:;|0:b|1:,|0:c|1:,',      '.caps on %% separator';
is ca($/.chunks),   '0:a|1:;|0:b|1:,|0:c|1:,',  '.chunks on %% separator';

#?niecza skip 'conjunctive regex terms - nyi'
{
    ok 'a' ~~ m/a && <alpha>/, 'Regex matches';
    is ca($/.caps),     'alpha:a',  '.caps && - first term';

    ok 'a' ~~ m/<alpha> && a/,  'Regex matches';
    is ca($/.caps),     'alpha:a',  '.caps && - last term';

    ok 'a' ~~ m/<alpha> & <ident>/,  'Regex matches';
#?rakudo.jvm todo '& caps on jvm'
    is ca($/.caps),     'alpha:a|ident:a',  '.caps & - multiple terms';

    ok 'a' ~~ m/<alpha> && <ident>/,  'Regex matches';
#?rakudo.jvm todo '&& caps on jvm'
    is ca($/.caps),     'alpha:a|ident:a',  '.caps && - multiple terms';

    ok 'ab' ~~ m/([a|b] && <alpha>)**1..2/,  'Regex matches';
    is ca($/.caps),     '0:a|0:b',    '.caps on quantified &&';

    ok 'ab' ~~ m/[[a|b] && <alpha>]**1..2/,  'Regex matches';
#?rakudo todo 'RT #117955 - quantified conjunctive capture'
    is ca($/.caps),     'alpha:a|alpha:b',    '.caps on quantified &&';
}

done;

# vim: ft=perl6
