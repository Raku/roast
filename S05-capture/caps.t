use v6;
use Test;
plan 8;

# L<S05/Match objects/"$/.caps">

ok 'a b c d' ~~ /(.*)/, 'basic sanity';
is $/.caps.join('|'), 'a b c d', '$/.caps is one item for (.*)';

token wc { \w };

ok 'a b c' ~~ /:s <wc> (\w) <wc> /, 'regex matches';
is $/.caps.join('|'), 'a|b|c', 'named and positional captures mix correctly';

ok 'a b c d' ~~ /[(\w) \s*]+/, 'regex matches';
is $/.caps.join('|'), 'a|b|c|d', '[(\w)* \s*]+ flattens (...)* for .caps';

ok 'a b c d' ~~ /:s [(\w) <wc> ]+/, 'regex matches';
is $/.caps.join('|'), 'a|b|c|d', 
                      'mixed named/positional flattening with quantifiers';


# vim: ft=perl6
