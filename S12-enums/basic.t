use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 54;

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

#?rakudo todo 'rakudo#1296 butting issue on Str and Enum'
{
    # https://github.com/Raku/old-issue-tracker/issues/4014
    # this is originally about RT #124832, but issue goes different.
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
    # usually we don't test explicit value for .raku, but here
    # it's specced, so we make an exception
    is Day::Mon.raku, 'Day::Mon', '.raku on long form of Pair key';
    is Mon.raku,      'Day::Mon', '.raku on short form of Pair value';

    is Day::Mon.key,  'Mon',      '.key on long form of Pair value';
    is Mon.key,       'Mon',      '.key on short form of Pair value';

    is Day::Mon.WHAT.gist, '(Day)',    '.WHAT.gist on enum value stringifies to the enum name';
}

{
    my enum roman (i => 1,   v => 5,
                x => 10,  l => 50,
                c => 100, d => 500,
                m => 1000);
    ok v == 5, 'enum with parens works and non-0 starting point works';
    is v.raku, 'roman::v', '.raku works on enum with parens';
    is v.key,  'v',        '.key works on enum with parens';
}


{
    my enum JustOne <Thing>;
    ok JustOne::Thing == 0, 'Pair of one element works.';
}

lives-ok { my enum Empty < > }, "empty enum can be constructed";

eval-lives-ok 'my enum Empty2 ()', 'empty enum with () can be constructed';

{
    my enum Color <white gray black>;
    my Color $c1 = Color::white;
    ok($c1 == 0, 'can assign enum value to typed variable with long name');
    my Color $c2 = white;
    ok($c2 == 0, 'can assign enum value to typed variable with short name');
    dies-ok({ my Color $c3 = "for the fail" },
        'enum as a type enforces checks');

    # conflict between subs and enums
    sub white { 'sub' };
    ok white == 0, 'short name of the enum without parenthesis is an enum';
    is white(), 'sub', 'short name with parenthesis is a sub';

    # L<S12/The C<.pick> Method/"define a .pick method">
    lives-ok { my Color $k = Color.pick }, 'Color.pick assigns to Color var';
    isa-ok Color.pick, Color.pick.WHAT, 'Color.pick.isa';

    ok ?(Color.pick == any(Color::white, Color::gray, Color::black)),
            '.pick on enums';
    ok Color.pick(2) == 2, '.pick(2) on enums';
}

# https://github.com/Raku/old-issue-tracker/issues/1448
{
    my enum RT71460::Bug <rt71460 bug71460 ticket71460>;
    ok bug71460 == 1, 'enum element of enum with double colons is in namespace';
}

# https://github.com/Raku/old-issue-tracker/issues/2182
{
    my enum T1 <a b c>;
    my enum T2 <d e f>;
    is T1.enums.keys.sort.join('|'), 'a|b|c', 'enum keys (1)';
    is T2.enums.keys.sort.join('|'), 'd|e|f', 'enum keys (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/1788
{
    my enum somenum <a b c d e>;
    my somenum $temp = d;
    ok $temp eq 'd', "RT #75370 enum name";
}

# https://github.com/Raku/old-issue-tracker/issues/1492
{
    my enum S1 <a b c>;
    my enum S2 <b c d>;
    throws-like { say b }, X::PoisonedAlias, :alias<b>, :package-type<enum>, :package-name<S2>;
    ok S1::b == 1 && S2::b == 0, 'still can access redeclared enum values via package';
}

# https://github.com/Raku/old-issue-tracker/issues/5315
{
    my enum Foo <a b>;
    isa-ok Foo.enums, Map, '.enums returns a Map';
}

# https://github.com/Raku/old-issue-tracker/issues/3773
subtest 'dynamically created lists can be used to define an enum' => {
    plan 2;
    my enum rt124251 ('a'..'c' X~ 1 .. 2);
    cmp-ok b2, '==', 3, 'enum element has correct value';
    is-deeply rt124251.enums, Map.new( (:0a1,:1a2,:2b1,:3b2,:4c1,:5c2) ),
        '.enums are all correct';
}

{ # coverage; 2016-10-03
    my enum Cover20161003 (|<foo-cover bar-cover>, fo2-cover => 0);
    subtest 'Enumeration:D.kv' => {
        plan 3;
        is-deeply foo-cover.kv, ('foo-cover', 0), 'first element';
        is-deeply bar-cover.kv, ('bar-cover', 1), 'second element';
        is-deeply fo2-cover.kv, ('fo2-cover', 0), 'element with duped value';
    }
    subtest 'Enumeration:D.pair' => {
        plan 3;
        is-deeply foo-cover.pair, (foo-cover => 0), 'first element';
        is-deeply bar-cover.pair, (bar-cover => 1), 'second element';
        is-deeply fo2-cover.pair, (fo2-cover => 0), 'element with duped value';
    }
    subtest 'Enumeration:D.Int' => {
        plan 3;
        is-deeply foo-cover.Int, 0, 'first element';
        is-deeply bar-cover.Int, 1, 'second element';
        is-deeply fo2-cover.Int, 0, 'element with duped value';
    }
}

subtest '.pred/.succ' => {
    plan 10;

    sub is-enum-named ($enum, $wanted, $desc) { is $enum.pair.key, $wanted, $desc }
    my enum PredSuccTester (A => 1, B => 2, C => 2, D => 3, E => 3);

    A.pred.&is-enum-named: A, '.pred on first element, returns first element';
    B.pred.&is-enum-named: A, '.pred on second element, returns first element';
    C.pred.&is-enum-named: B, '.pred on 3rd element, returns 2nd element, even if values are same';
    E.pred.&is-enum-named: D, '.pred on last element, returns previous, even if values are same';

    A.succ.&is-enum-named: B, '.succ on first element, returns second element';
    B.succ.&is-enum-named: C, '.succ second element, returns third one, even if values are same';
    D.succ.&is-enum-named: E, '.succ 4th element, returns 5th element, even if values are same';
    E.succ.&is-enum-named: E, '.succ last element, returns last element';

    my enum Lonely < Z >;
    Z.pred.&is-enum-named: Z, '.pred on enum with 1 value works';
    Z.succ.&is-enum-named: Z, '.succ on enum with 1 value works';
}

# https://github.com/Raku/old-issue-tracker/issues/6522
subtest '=== on different enums with same values' => {
    plan 6;
    my enum WHICHTester (A => 1, B => 2, C => 2);

    cmp-ok A, &[!===], B, 'different enums; different values => different';
    cmp-ok B, &[!===], C, 'different enums; same values => different';
    cmp-ok WHICHTester, &[!===], A, 'type object vs. instance => different';

    cmp-ok B, &[===],  B, 'same enums => same (1)';
    cmp-ok C, &[===],  C, 'same enums => same (2)';
    cmp-ok WHICHTester, &[===], WHICHTester, 'type object vs. type object => same';
}

# https://github.com/Raku/old-issue-tracker/issues/6498
cmp-ok Bool.enums.WHAT, '===', Map, 'Bool.enums returns a Map, not a Hash';

# https://github.com/Raku/old-issue-tracker/issues/3049
{
  lives-ok {
    my enum RT116719 (<red green purple> Z=> 1,2,4);
    is-deeply RT116719.enums, Map.new((green => 2, purple => 4, red => 1)),
      'build enum using Z=> operator properly';
  }, 'can build enum using Z=> operator';
}

# https://github.com/Raku/old-issue-tracker/issues/3612
group-of 3 => 'can build enum with built-ins\' names' => {
  eval-lives-ok q[enum RT1234571 <Block>; subset B;], 'Block';
  eval-lives-ok q[enum RT1234572 <Code>], 'Code';
  eval-lives-ok q[enum RT1234573 <Code> #123457], 'Code';
}

# https://github.com/Raku/old-issue-tracker/issues/5272
{ 
    my enum RT128017 ( (('RT128017-' X~ 1..8) Z=> (1, 2, 4 ... 256)) );
    is-deeply RT128017.enums,  Map.new((
        "RT128017-1" => 1,"RT128017-2" => 2,"RT128017-3" => 4,
        "RT128017-4" => 8,"RT128017-5" => 16,"RT128017-6" => 32,
        "RT128017-7" => 64,"RT128017-8" => 128
    )), 'enums can be created via Seq of Pairs';
}

# https://github.com/Raku/old-issue-tracker/issues/5785
subtest 'can provide enum values via Pairs' => {
    plan 5;

    my enum RT130041 (
        'RT130041-A' => 42, 'RT130041-B',
        'RT130041-C' => 22, 'RT130041-D', 'RT130041-E',
    );
    is-deeply +RT130041-A, 42, '(1)';
    is-deeply +RT130041-B, 43, '(2)';
    is-deeply +RT130041-C, 22, '(3)';
    is-deeply +RT130041-D, 23, '(4)';
    is-deeply +RT130041-E, 24, '(5)';
}

# https://github.com/Raku/old-issue-tracker/issues/5943
is-deeply do { BEGIN my %h = <a 1 b 2>; my enum Bits (%h); Bits.enums },
    Map.new((:a<1>,:b<2>)), 'can create enum with a Hash';

# https://github.com/rakudo/rakudo/commit/fc52143bee
is-deeply do { my enum Foos (a => <42>); a.Str }, 'a',
    '"NumericStringyEnumeration" uses key as .Str value';

# https://github.com/Raku/old-issue-tracker/issues/3546
{ 
    my enum Bug ("foo" => -42, "A", "bar" => 100, "B", :12ber, "C", "D");
    is-deeply [+foo, +A,  +bar, +B,  +ber, +C, +D],
              [-42,  -41, 100,  101, 12,   13, 14],
    'Pair elements in the list given to enum declaration work';
}

# https://github.com/Raku/old-issue-tracker/issues/5627
{ 
    eval-lives-ok 'my enum FF <zero one two three>; my enum GG <fee fie foo fum>; { FF(GG(2)).raku }',
                  'Coercing an enum from a coercion of an enum from an int works';
}

# vim: expandtab shiftwidth=4
