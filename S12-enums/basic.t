use v6;
use Test;
plan 9;

# Very basic enum tests

# L<S12/Enums/values are specified as a list>

enum Day <Sun Mon Tue Wed Thu Fri Sat>;
{
    is Day::Sun, 0, 'First item of an enum is 0';
    is Day::Sat, 6, 'Last item has the right value';
    is Sun,      0, 'Values exported into namespace too.';
    is Sat,      6, 'Values exported into namespace too.';
}

{
    my $x = 'Today' but Day::Mon;
    #?rakudo 2 skip '.does missing'
    ok $x.does(Day),      'Can test with .does() for enum type';
    ok $x.does(Day::Mon), 'Can test with .does() for enum value';
    ok $x ~~ Day,         'Can smartmatch for enum type';
    #?rakudo 1 skip 'ACCEPTS missing for enum values'
    ok $x ~~ Day::Mon,    'Can Smartmatch for enum value';
}

enum JustOne <Thing>;
{
    is JustOne::Thing, 0, 'Enum of one element works.';
}
