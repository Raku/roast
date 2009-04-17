use v6;

use Test;

plan 3;

# Note that @*INC is only provisional until we have plans for a "real"
# module database in place.
#
# L<S28/Perl5 to Perl6 special variable translation/"@*INC">

ok(+@*INC > 0, 'we have something in our @INC');

my $number_in_inc = +@*INC;
push @*INC, 'test';
is(+@*INC, $number_in_inc + 1, 'we added something to @INC');

pop @*INC;
is(+@*INC, $number_in_inc, 'we removed something from @INC');

# vim: ft=perl6
