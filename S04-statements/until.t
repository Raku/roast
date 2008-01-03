use v6-alpha;
use Test;

plan 4;

# L<S04/The C<while> and C<until> statements/while statements
#   work as in 5>
{
    my $i = 0;
    until $i >= 5 { $i++; };
    is($i, 5, 'until $i >= 5 {} works');
}

{
    my $i = 0;
    until 5 <= $i { $i++; };
    is($i, 5, 'until 5 <= $i {} works');
}

# with parens
{
    my $i = 0;
    until ($i >= 5) { $i++; };
    is($i, 5, 'until ($i >= 5) {} works');
}

{
    my $i = 0;
    until (5 <= $i) { $i++; };
    is($i, 5, 'until (5 <= $i) {} works');
}
