use v6;
use Test;
plan 8;

=begin description

Testing the C<:aa> or C<:sameaccent> modifier - as always, need more tests

=end description

#?pugs 999 skip feature
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

{
    my $s = 'aäää oööö';
    ok $s ~~ s:aa:s/a+ o+/OOO UU/, 'combined :aa and :s match';
    is $s, 'OÖÖ UÜ', ':aa :s carry accents on a word-by-word base';
}


# vim: ft=perl6
