use v6.c;
# http://perl6advent.wordpress.com/2010/12/07/day-7-lexical-variables/

use Test;

plan 8;

throws-like {EVAL '{ $var = 42 }'}, X::Undeclared;
lives-ok {EVAL '{ my $var = 42 }'};
throws-like {EVAL '{ my $var = 42 }; say $var'}, X::Undeclared;

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
