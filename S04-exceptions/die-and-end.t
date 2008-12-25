use v6;
plan 1;

my $x = 0;
eval 'END { $x = 1 }; die "fatal";';
is $x, 1, 'die() does not prevent END block from being run';

# vim: ft=perl6
