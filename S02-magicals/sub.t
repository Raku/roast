use v6;

use Test;

=begin comment

This tests the &?ROUTINE magical value

=end comment

plan 4;

# L<S06/The C<&?ROUTINE> object>
# L<S02/Names/Which routine am I in>
sub factorial { @_[0] < 2 ?? 1 !! @_[0] * &?ROUTINE(@_[0] - 1) }

my $result1 = factorial(3);
is($result1, 6, 'the &?ROUTINE magical works correctly');

my $factorial = sub { @_[0] < 2 ?? 1 !! @_[0] * &?ROUTINE(@_[0] - 1) };
my $result2 = $factorial(3);
is($result2, 6, 'the &?ROUTINE magical works correctly in anon-subs');

sub postfix:<!!!> (Int $n) { $n < 2 ?? 1 !! $n * &?ROUTINE($n - 1) }
my $result3 = 3!!!;
is($result3, 6, 'the &?ROUTINE magical works correctly in overloaded operators' );

#?rakudo todo 'is this spec?'
{
    my $baz = try { &?ROUTINE };
    ok(defined($baz), '&?ROUTINE is defined for the MAIN routine');
}

# vim: ft=perl6
