use v6;

use Test;

plan 4;

=begin pod

Perl 6 has an explicitly declared C<=~> which should die at compile time
and is intended to catch user "brainos"; it recommends C<~~> to the user
instead. Similar for C<!~>.

=end pod

#L<S03/Chaining binary precedence/"To catch">

my $str = 'foo';
eval '$str =~ m/bar/;';
ok  $!  ~~ Exception, 'caught "=~" braino';
ok "$!" ~~ /'~~'/, 'error for "=~" usage mentions "~~"';

eval '$str !~ m/bar/;';
ok  $!  ~~ Exception, 'caught "!~" braino';
ok "$!" ~~ /'!~~'/, 'error for "!~" usage mentions "!~~"';

# vim: ft=perl6
