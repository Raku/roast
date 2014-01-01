use v6;
use Test;
plan 1;

my $self = "some text";

is ~EVAL(q/"self is $self"/,:lang<perl5>),"self is some text","lexical inside an EVAL";

# vim: ft=perl6
