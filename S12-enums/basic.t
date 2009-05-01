use v6;
use Test;
plan 24;

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
    #?rakudo 1 todo 'ACCEPTS missing for enum values'
    ok $x ~~ Day::Mon,    'Can Smartmatch for enum value';
}

{
    # usually we don't test explicit value for .perl, but here
    # it's specced, so we make an excpetion
    is Day::Mon.perl, 'Day::Mon', '.perl on long form of Enum value';
    is Mon.perl,      'Day::Mon', '.perl on short form of Enum value';

    is Day::Mon.name, 'Mon',      '.name on long form of Enum value';
    is Mon.name,      'Mon',      '.name on short form of Enum value';

    is Day::Mon.WHAT, 'Day',      '.WHAT on enum value stringifies to the enum name';
}

enum roman (i => 1,   v => 5,
            x => 10,  l => 50,
            c => 100, d => 500,
            m => 1000);
{
	is v,      5,          'enum with parens works and non-0 starting point works';
      is v.perl, 'roman::v', '.perl works on enum with parens';
      is v.name, 'v',        '.name works on enum with parens';
}

enum JustOne <Thing>;
{
    is JustOne::Thing, 0, 'Enum of one element works.';
}

lives_ok { enum Empty < > }, "empty enum can be constructed";

eval_lives_ok 'enum Empty2 ()', 'empty enum with () can be constructed';

enum Color <white gray black>;
my Color $c1 = Color::white;
is($c1, 0, 'can assign enum value to typed variable with long name');
my Color $c2 = white;
is($c1, 0, 'can assign enum value to typed variable with short name');
dies_ok({ my Color $c3 = "for the fail" }, 'enum as a type enforces checks');

# L<S12/Enums/"Like type names, enum names are parsed as standalone tokens">
# conflict between subs and enums
{
    sub white { 'sub' };
    is white, 0, 'short name of the enum without parenthesis is an enum';
    #?rakudo skip 'subs and enums with conflicting names'
    is white(), 'sub', 'short name with parenthesis is a sub';
}
