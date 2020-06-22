use v6;
use Test;

plan 2;

{
    my $a = 42;
    lives-ok { use isms <Perl5>; $a=~$a }, "does =~ survive?";
    is-deeply $a, "42", "did it actually do the assignment?";
}

# vim: expandtab shiftwidth=4
