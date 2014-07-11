use v6;
use Test;
plan 8;

=begin description

Testing the C<:mm> or C<:samemark> modifier - as always, need more tests

# L<S05/Modifiers/:samemark>

=end description

{
    my $s = 'äaä';
    ok $s ~~ s:mm/aaa/ooo/, ':mm implies :m';
    is $s, 'öoö', 
       ':mm transported mark information from source to destination';
}

{
    my $s = 'äa';
    ok $s ~~ s:mm/a+/oooo/, ':mm works with quantified atoms';
    is $s, 'öooo', ':mm transported case information to longer substitution string';
}

{
    my $s = 'aä';
    ok $s ~~ s:mm/a+/oooo/, ':mm works with quantified atoms';
    is $s, 'oööö', ':mm transported case information to longer substitution string';
}

{
    my $s = 'aäää oööö';
    ok $s ~~ s:mm:s/a+ o+/OOO UU/, 'combined :mm and :s match';
    is $s, 'OÖÖ UÜ', ':mm :s carry marks on a word-by-word base';
}


# vim: ft=perl6
