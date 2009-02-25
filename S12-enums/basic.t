use v6;
use Test;
plan 13;

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
    #?rakudo 1 skip '.does for enum type'
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

lives_ok { enum Empty <> }, "empty enum can be constructed";

enum Color <white gray black>;
my Color $c1 = Color::white;
is($c1, 0, 'can assign enum value to typed variable with long name');
my Color $c2 = white;
is($c1, 0, 'can assign enum value to typed variable with short name');
dies_ok({ my Color $c3 = "for the fail" }, 'enum as a type enforces checks');
