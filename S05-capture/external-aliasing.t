use v6;
use Test;

plan 16;

# L<S05/External aliasing/>

my $x;
our $y;

ok 'ab cd ef' ~~ m/:s <ident> $x=<ident> $y=<ident>/, 
   'regex matched';
isa_ok $x, Match, 'stored a match object in outer lexical var';
isa_ok $y, Match, 'stored a match object in outer package var';
isa_ok $<ident>, Match, '... the normal capture also is a Match object';
is ~$<ident>, 'ab', 'normal match object still works';
is ~$x, 'cd', 'outer lexical var got the right value';
is ~$y, 'ef', 'outer package var got the right value';

# this is a bit guesswork here on how outer vars interact with .caps and
# .chunks. It seems sane to assume that .caps will ignore those parts that
# are bound to external variables (since it knows nothing about them)

is +$/.caps, 'one capture';
is ~$/.caps.[0].value, 'ab', 'right value in .caps';
is +$/.chunks, 2, 'two chunks';
is $/.chunks.map({.key}).join('|'), 'ident|~', 'right keys of .chunks';
is $/.chunks.map({.value}).join('|'), 'ab| cd ef', 'right values of .chunks';

{
    my @a;
    ok 'abc' ~~ m/@a=(.)+/, 'regex with outer array matches';
    is +@a, 3, 'bound the right number of matches';
    ok ?(all(@a) ~~ Match), 'All of them are Match objects';
    is @a.join('|'), 'a|b|c', 'right values';
}

# vim: ft=perl6
