use v6;
use Test;
plan 1;

my $self = "some text";

#?rakudo todo ''
is ~EVAL(q/"self is $self"/,:lang<Perl5>),"self is some text","lexical inside an EVAL";

# vim: ft=perl6
