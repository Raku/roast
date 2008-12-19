use v6;
use Test;

plan 2;

sub run_perl (Str $prog) {
    my $quote =  $*OS ~~ m:i/win/ ?? q{"} !! q{'};
    return qq:x{$*PERL -e $quote$prog$quote};
}

is run_perl(q{my $a = [1, 2, 3]; say   $a}), "1 2 3\n", 'Can say array ref';
is run_perl(q{my $a = [1, 2, 3]; print $a}), "1 2 3\n", 'Can print array ref';

# vim: ft=perl6
