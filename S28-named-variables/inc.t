use v6;

use Test;

plan 5;

# Note that @*INC is only provisional until we have plans for a "real"
# module database in place.
#
# L<S28/Perl5 to Perl6 special variable translation/"@*INC">

#?niecza todo
ok(+@*INC > 0, 'we have something in our @INC');

my $number_in_inc = +@*INC;
push @*INC, 'test';
is(+@*INC, $number_in_inc + 1, 'we added something to @INC');

#?pugs emit # cannot pop scalar
pop @*INC;
#?pugs skip 'cannot pop scalar'
is(+@*INC, $number_in_inc, 'we removed something from @INC');

lives_ok { @*INC = <a b c> }, 'Can assign to @*INC';
is @*INC.join(','), 'a,b,c', '... and assignment worked';

# vim: ft=perl6
