use v6;
use Test;
plan 2;

# L<S04/The Relationship of Blocks and Declarations/"A bare closure without
# placeholder arguments that uses $_">

{
    # test with explicit $_
    my $f1 = { 2*$_ };
    is $f1(2), 4, 'Block with explit $_ has one formal paramter';
}

{
    # test with implicit $_
    my $f2 = { .sqrt };
    is_approx $f2(4), 2, 'Block with implict $_ has one formal parameter';
}
