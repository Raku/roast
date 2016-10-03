use v6;
use Test;
plan 42;

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
    isa-ok (Mon..Wed), Range, 'Can construct ranges from Pair values';
    ok Mon + Tue == Wed, 'Can do arithmetics with Pair values';
}

#?rakudo skip 'Cannot convert string to number RT #124832'
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
    is Day::Mon.perl, 'Day::Mon', '.perl on long form of Pair key';
    is Mon.perl,      'Day::Mon', '.perl on short form of Pair value';

    is Day::Mon.key,  'Mon',      '.key on long form of Pair value';
    is Mon.key,       'Mon',      '.key on short form of Pair value';

    is Day::Mon.WHAT.gist, '(Day)',    '.WHAT.gist on enum value stringifies to the enum name';
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
    ok JustOne::Thing == 0, 'Pair of one element works.';
}

#?niecza skip "Pair must have at least one value"
lives-ok { enum Empty < > }, "empty enum can be constructed";

#?niecza todo "Pair must have at least one value"
eval-lives-ok 'enum Empty2 ()', 'empty enum with () can be constructed';

enum Color <white gray black>;
my Color $c1 = Color::white;
ok($c1 == 0, 'can assign enum value to typed variable with long name');
my Color $c2 = white;
ok($c2 == 0, 'can assign enum value to typed variable with short name');
dies-ok({ my Color $c3 = "for the fail" }, 'enum as a type enforces checks');

# conflict between subs and enums
{
    my sub white { 'sub' };
    ok white == 0, 'short name of the enum without parenthesis is an enum';
    #?niecza skip 'nonworking'
    is white(), 'sub', 'short name with parenthesis is a sub';
}

# L<S12/The C<.pick> Method/"define a .pick method">
{
    lives-ok { my Color $k = Color.pick }, 'Color.pick assigns to Color var';
    isa-ok Color.pick, Color.pick.WHAT, 'Color.pick.isa';

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

# RT #75370
{
    enum somenum <a b c d e>;
    my somenum $temp = d;
    ok $temp eq 'd', "RT #75370 enum name";
}

# RT #72696
{
    enum S1 <a b c>;
    enum S2 <b c d>;
    throws-like { say b }, X::PoisonedAlias, :alias<b>, :package-type<enum>, :package-name<S2>;
    ok S1::b == 1 && S2::b == 0, 'still can access redeclared enum values via package';
}

# RT #128138
{
    enum Foo <a b>;
    isa-ok Foo.enums, Map, '.enums returns a Map';
}

# RT #124251
subtest 'dynamically created lists can be used to define an enum' => {
    plan 2;
    my enum rt124251 ('a'..'c' X~ 1 .. 2);
    cmp-ok b2, '==', 3, 'enum element has correct value';
    is-deeply rt124251.enums, Map.new( (:0a1,:1a2,:2b1,:3b2,:4c1,:5c2) ),
        '.enums are all correct';
}

{ # coverage; 2016-10-03
    my enum Cover20161003 <foo-cover bar-cover>;
    subtest 'Enumeration:D.kv' => {
        plan 2;
        is-deeply foo-cover.kv, ('foo-cover', 0), 'first element';
        is-deeply bar-cover.kv, ('bar-cover', 1), 'second element';
    }
    subtest 'Enumeration:D.pair' => {
        plan 2;
        is-deeply foo-cover.pair, (foo-cover => 0), 'first element';
        is-deeply bar-cover.pair, (bar-cover => 1), 'second element';
    }
    subtest 'Enumeration:D.Int' => {
        plan 2;
        is-deeply foo-cover.Int, 0, 'first element';
        is-deeply bar-cover.Int, 1, 'second element';
    }
}

# vim: ft=perl6
