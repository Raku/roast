use v6;
use Test;
plan 1;

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

my $self = "some text";

#?rakudo todo ''
is ~EVAL(q/"self is $self"/,:lang<Perl5>),"self is some text","lexical inside an EVAL";

# vim: ft=perl6
