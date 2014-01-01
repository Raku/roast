use v6;

use Test;

plan 9;

=begin pod

Perl 6 has an explicitly declared C<=~> which should die at compile time
and is intended to catch user "brainos"; it recommends C<~~> to the user
instead. Similar for C<!~>.

=end pod

#L<S03/Chaining binary precedence/"To catch">

my $str = 'foo';
try { EVAL '$str =~ m/bar/;' };
ok  $!  ~~ Exception, 'caught "=~" braino';
ok "$!" ~~ /'~~'/, 'error for "=~" usage mentions "~~"';

try { EVAL '$str !~ m/bar/;' };
ok  $!  ~~ Exception, 'caught "!~" braino';
ok "$!" ~~ /'!~~'/, 'error for "!~" usage mentions "!~~"';

# RT #76878
{
    my $x = 2;
    is EVAL('"$x =~ b"'), '2 =~ b', '=~ allowed in double quotes';
    is EVAL('"$x !~ b"'), '2 !~ b', '!~ allowed in double quotes';
    is EVAL('"$x << b"'), '2 << b', '<< allowed in double quotes';
    is EVAL('"$x >> b"'), '2 >> b', '>> allowed in double quotes';
    is EVAL('"$x . b"'),  '2 . b',  '.  allowed in double quotes';
}

# vim: ft=perl6
