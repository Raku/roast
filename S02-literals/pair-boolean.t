use v6;

use Test;

=begin pod

The ? case definitely shouldn't be a syntax error.  The next question is
what the correct boolean value is for a Pair; always-true is now assumed
for consistency with the "one-key hash" semantics.

=end pod

#L<S02/Literals/>

plan 6;

# See thread "Stringification, numification, and booleanification of pairs" on
# p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/23148">

{
    my $true_pair  = 1 => 1;
    my $false_pair = 1 => 0;

    lives-ok { ?$true_pair  }, 'Taking the boolean of a true pair should live';
    lives-ok { ?$false_pair }, 'Taking the boolean of a false pair should live';
    ok  (try { ?$true_pair  }), 'A pair with a true value is true';
    ok  (try { ?$false_pair }), 'A pair with a false value is also true';

    is $true_pair  ?? 1 !! 0, 1, 'Ternary on a true pair returns first option';
    is $false_pair ?? 1 !! 0, 1, 'Ternary on a false pair returns first option too';
}

# vim: ft=perl6
