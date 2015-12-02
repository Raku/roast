use v6;

use Test;

plan 7;

# L<S04/Phasers/FIRST "at loop initialization time">
#?rakudo.jvm todo 'RT #126701'
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
    nok $a_in_first.defined, 'FIRST {} ran before the loop body';
}

# L<S04/Phasers/can occur multiple times>
#?rakudo.jvm todo 'RT #126701'
{
    my $str = '';
    for 1..2 {
        FIRST { $str ~= $_ }
        FIRST { $str ~= ':' }
        FIRST { $str ~= ' ' }
    }
    is $str, '1: ', 'multiple FIRST {} ran in order';
}

# L<S04/Phasers/FIRST "at loop initialization time" "before any ENTER">
#?rakudo.jvm todo 'RT #126701'
{
    my $str = '';
    for 1..2 {
        FIRST { $str ~= 'f1' }
        ENTER { $str ~= 'e' }
        FIRST { $str ~= 'f2' }
    }
    is $str, 'f1f2ee', 'FIRST {} ran before ENTER {}';
}

{
    my $i=0;
    my $str = '';
    while $i < 3 {
        FIRST { $str ~= 'Here' }
        $str ~= $i++;
    }
    is $str, 'Here012', 'FIRST in while loop runs';
}

# RT #121147
{
    my $i=0;
    my $str = '';
    while $i < 3 {
        FIRST { $str ~= 'Here'; last }
        $str ~= $i++;
    }
    is $str, 'Here', 'last in FIRST in while loop works';
}

{
    my $str = '';
    for 1..3 {
        FIRST { $str ~= 'Here'; last }
        $str ~= $_;
    }
    is $str, 'Here', 'last in FIRST in for loop works';
}

# vim: ft=perl6
