use v6;
use Test;
plan 6;

=begin description

Testing the C<:aa> or C<:sameaccent> modifier - as always, need more tests

=end description

{
    my $s = 'äaä';
    ok $s ~~ s:aa/aaa/ooo/, ':aa implies :a';
    is $s, 'öoö', 
       ':aa transported accent information from source to destination';
}

{
    my $s = 'äa';
    ok $s ~~ s:aa/a+/oooo/, ':aa works with quantified atoms';
    is $s, 'öooo', ':aa transported case information to longer substitution string';
}

{
    my $s = 'aä';
    ok $s ~~ s:aa/a+/oooo/, ':aa works with quantified atoms';
    is $s, 'oööö', ':aa transported case information to longer substitution string';
}


# vim: ft=perl6
