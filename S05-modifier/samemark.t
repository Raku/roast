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
    is $s, 'öooo', ':mm transported mark information to longer substitution string';
}

{
    my $s = 'aä';
    ok $s ~~ s:mm/a+/oooo/, ':mm works with quantified atoms';
    is $s, 'oöoo', ':mm transported mark information to longer substitution string but does not propagate';
}

{
    my $s = 'aäää öoöö';
    ok $s ~~ s:mm:s/a+ o+/OOOOO UUU/, 'combined :mm and :s match';
    is $s, 'OÖÖÖO ÜUÜ', ':mm :s carry marks on a word-by-word base';
}


# vim: ft=perl6
