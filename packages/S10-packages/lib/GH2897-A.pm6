use v6;
unit module GH2897-A;

sub gen-counter is export {
    my $foo = 0;
    sub counter { $foo++ }
}

# vim: expandtab shiftwidth=4
