use v6;

use Test;

plan 4;

# L<S04/Closure traits/FIRST "at loop initialization time">
{
    my $str = '';
    for 1..2 {
        FIRST { $str ~= $_ }
    }
    is $str, 1, 'FIRST only ran once';
}

{
    my ($a, $a_in_first);
    for 1..2 {
        $a++;
        FIRST { $a_in_first = $a }
    }
    is $a_in_first, undef, 'FIRST {} ran before the loop body';
}

# L<S04/Closure traits/can occur multiple times>
{
    my $str = '';
    for 1..2 {
        FIRST { $str ~= $_ }
        FIRST { $str ~= ':' }
        FIRST { $str ~= ' ' }
    }
    is $str, '1: ', 'multiple FIRST {} ran in order';
}

# L<S04/Closure traits/FIRST "at loop initialization time" "before any ENTER">
{
    my $str = '';
    for 1..2 {
        FIRST { $str ~= 'f1' }
        ENTER { $str ~= 'e' }
        FIRST { $str ~= 'f2' }
    }
    is $str, 'f1f2ee', 'FIRST {} ran before ENTER {}';
}
