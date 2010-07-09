use v6;

# Tests for a bug uncovered when Jesse Vincent was testing
# functionality for Patrick Michaud
# TODO: add smartlinks, more tests

use Test;

plan 6;


my @list = ('a');


# Do pointy subs send along a declared param?

for @list -> $letter { is( $letter , 'a', 'can bind to variable in pointy') }

#?rakudo skip 'for() with nullary block'
{
    # Do pointy subs send along an implicit param? No!
    for @list -> {
        isnt($_, 'a', '$_ does not get set implicitly if a pointy is given')
    }
}

# Hm. PIL2JS currently dies here (&statement_control:<for> passes one argument
# to the block, but the block doesn't expect any arguments). Is PIL2JS correct?

# Do pointy subs send along an implicit param even when a param is declared? No!
for @list -> $letter {
    isnt( $_ ,'a', '$_ does not get set implicitly if a pointy is given')
}

{
    my $a := $_; $_ = 30;
    for 1 .. 3 { $a++ };
    is $a, 33, 'outer $_ increments' ;
}

{
    my @mutable_array = 1..3;
    lives_ok { for @mutable_array { $_++ } }, 'default topic is rw by default';
}

{
    $_ = 1;
    my $tracker = '';

    for 11,12 -> $a {
        if $_ == 1 { $tracker ~= "1 : $_|"; $_ = 2; }
        else {       $tracker ~= "* : $_" }
    }

    is $tracker, '1 : 1|* : 2',
        'Two iterations of a loop share the same $_ if it is not a formal parameter';
}

# vim: ft=perl6
