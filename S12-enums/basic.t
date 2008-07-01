use v6;
use Test;
plan 6;

# Very basic enum tests

# L<S12/Enums/values are specified as a list>

enum Day <Sun Mon Tue Wed Thu Fri Sat>;
{
    is Day::Sun, 0, 'First item of an enum is 0';
    is Day::Sat, 6, 'Last item has the right value';
}

{
    my $x = 'Today' but Day::Mon;
    ok $x.does(Day),      'Can test with .does() for enum type';
    ok $x.does(Day::Mon), 'Can test with .does() for enum value';
    ok $x ~~ Day,         'Can smartmatch for enum type';
    ok $x ~~ Day::Mon,    'Can Smartmatch for enum value';
}

