use v6;
use Test;
plan 8;

=begin description

Testing the C<:mm> or C<:samemark> modifier - as always, need more tests

# L<S05/Modifiers/:samemark>

=end description

#?rakudo.jvm todo 'got äaä'
{
    my $s = 'äaä';
    ok $s ~~ s:mm/aaa/ooo/, ':mm implies :m';
    is $s, 'öoö', 
       ':mm transported mark information from source to destination';
}

#?rakudo.jvm skip 'samemark NYI'
{
    my $s = 'äa';
    ok $s ~~ s:mm/a+/oooo/, ':mm works with quantified atoms';
    is $s, 'öooo', ':mm transported mark information to longer substitution string';
}

#?rakudo.jvm skip 'samemark NYI'
{
    my $s = 'aa⃨';
    ok $s ~~ s:mm/a+/oooo/, ':mm works with quantified atoms';
    is $s, 'oo⃨o⃨o⃨', ':mm transported mark information to longer substitution string';
}

#?rakudo.jvm todo 'got aääa öoöö'
{
    my $s = 'aääa öoöö';
    ok $s ~~ s:mm:s/a+ o+/OOOOO UUU/, 'combined :mm and :s match';
    is $s, 'OÖÖOO ÜUÜ', ':mm :s carry marks on a word-by-word base';
}


# vim: expandtab shiftwidth=4
