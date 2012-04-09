use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/prior.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 11;

# L<S05/Nothing is illegal/To match whatever the prior successful regex>

# so rule prior matches a constant substring

ok("A" !~~ m/<.prior>/, 'No prior successful match');

#?pugs todo
ok("A" ~~ m/<[A..Z]>/, 'Successful match');

#?pugs todo
ok("ABC" ~~ m/<.prior>/, 'Prior successful match');
ok("B" !~~ m/<.prior>/, 'Prior successful non-match');

ok("C" !~~ m/B/,  'Unsuccessful match');

#?pugs todo
ok("A" ~~ m/<.prior>/, 'Still prior successful match');
#?pugs todo
ok("A" ~~ m/<.prior>/, 'And still prior successful match');

#?pugs todo
ok("BA" ~~ m/B <.prior>/, 'Nested prior successful match');
#?pugs todo
is ~$/, 'BA', 'matched all we wanted';

# now the prior match is "BA"
ok("A" !~~ m/B <.prior>/, 'Nested prior successful non-match');
ok( 'A' !~~ m/<.prior>/, 'prior target updated');

# vim: ft=perl6
