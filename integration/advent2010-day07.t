# http://perl6advent.wordpress.com/2010/12/07/day-7-lexical-variables/

use v6;

use Test;

plan 8;

dies_ok {EVAL '{ $var = 42 }'};
lives_ok {EVAL '{ my $var = 42 }'};
dies_ok {EVAL '{ my $var = 42 }; say $var'};

sub counter($start_value) {
    my $count = $start_value;
    return { $count++ };
}

my $c1 = counter(5);
is $c1(), 5;
is $c1(), 6;

my $c2 = counter(42);
is $c2(), 42;
is $c1(), 7;
is $c2(), 43;
