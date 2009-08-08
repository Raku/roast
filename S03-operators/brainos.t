use v6;

use Test;

plan 3;

=begin pod

Perl 6 has an explicitly declared C<=~> which should die at compile time
and is intended to catch user "brainos"; it recommends C<~~> or C<~=> to
the user instead.

=end pod

#L<S03/Chaining binary precedence/"To catch">

my $str = 'foo';
eval '$str =~ m/bar/;';
ok  $!  ~~ Exception, 'caught "=~" braino';
ok "$!" ~~ /'~~'/, 'error for "=~" usage mentions "~~"';
ok "$!" ~~ /'~='/, 'error for "=~" usage metnions "~="';

# vim: ft=perl6
