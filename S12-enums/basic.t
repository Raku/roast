use v6;
use Test;

# Very basic enum tests

# L<S12/Enumerations/the keys are specified as a parenthesized list>

enum Day <Sun Mon Tue Wed Thu Fri Sat>;
{
    is 0 + Day::Sun, 0, 'First item of an enum is 0';
    is 0 + Day::Sat, 6, 'Last item has the right value';
    is 0 + Sun,      0, 'Values exported into namespace too.';
    is 0 + Sat,      6, 'Values exported into namespace too.';
}

{
    # check that the values can be used for ordinary tasks, like
    # constructing ranges
    isa_ok (Mon..Wed), Range, 'Can construct ranges from Enum values';
    ok Mon + Tue == Wed, 'Can do arithmetics with Enum values';
}

#?rakudo skip 'but'
#?niecza skip 'enummish but'
{
    my $x = 'Today' but Day::Mon;
    ok $x.does(Day),      'Can test with .does() for enum type';
    ok $x ~~ Day,         'Can smartmatch for enum type';
    ok $x ~~ Day::Mon,    'Can Smartmatch for enum value';
    my $check = 0;
    given $x {
        when Day::Mon { $check = 1 }
        when Day::Tue { $check = 2 }
    }
    is $check, 1,         'given/when with enum values';
    $check = 0;
    given $x {
        when Tue { $check = 1 }
        when Mon { $check = 2 }
    }
    is $check, 2,         'given/when with enum values';
}

{
    # usually we don't test explicit value for .perl, but here
    # it's specced, so we make an exception
    is Day::Mon.perl, 'Day::Mon', '.perl on long form of Enum key';
    is Mon.perl,      'Day::Mon', '.perl on short form of Enum value';

    is Day::Mon.key,  'Mon',      '.key on long form of Enum value';
    is Mon.key,       'Mon',      '.key on short form of Enum value';

    is Day::Mon.WHAT.gist, 'Day()',    '.WHAT.gist on enum value stringifies to the enum name';
}

{
    enum roman (i => 1,   v => 5,
                x => 10,  l => 50,
                c => 100, d => 500,
                m => 1000);
    ok v == 5, 'enum with parens works and non-0 starting point works';
    is v.perl, 'roman::v', '.perl works on enum with parens';
    is v.key,  'v',        '.key works on enum with parens';
}

enum JustOne <Thing>;
{
    ok JustOne::Thing == 0, 'Enum of one element works.';
}

#?niecza skip "Enum must have at least one value"
lives_ok { enum Empty < > }, "empty enum can be constructed";

#?niecza todo "Enum must have at least one value"
eval_lives_ok 'enum Empty2 ()', 'empty enum with () can be constructed';

enum Color <white gray black>;
my Color $c1 = Color::white;
ok($c1 == 0, 'can assign enum value to typed variable with long name');
my Color $c2 = white;
ok($c1 == 0, 'can assign enum value to typed variable with short name');
dies_ok({ my Color $c3 = "for the fail" }, 'enum as a type enforces checks');

# conflict between subs and enums
{
    my sub white { 'sub' };
    ok white == 0, 'short name of the enum without parenthesis is an enum';
    #?niecza skip 'nonworking'
    is white(), 'sub', 'short name with parenthesis is a sub';
}

# L<S12/The C<.pick> Method/"define a .pick method">
{
    lives_ok { my Color $k = Color.pick }, 'Color.pick assigns to Color var';
    isa_ok Color.pick, Color.pick.WHAT, 'Color.pick.isa';

    ok ?(Color.pick == any(Color::white, Color::gray, Color::black)),
            '.pick on enums';
    ok Color.pick(2) == 2, '.pick(2) on enums';
}

{
    enum RT71460::Bug <rt71460 bug71460 ticket71460>;
    ok bug71460 == 1, 'enum element of enum with double colons is in namespace';
}

# RT #77982
{
    enum T1 <a b c>;
    enum T2 <d e f>;
    is T1.enums.keys.sort.join('|'), 'a|b|c', 'enum keys (1)';
    is T2.enums.keys.sort.join('|'), 'd|e|f', 'enum keys (2)';
}

done;

# vim: ft=perl6
