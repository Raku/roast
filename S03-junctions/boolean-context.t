use v6;
use Test;
plan 77;

# L<S03/Junctive operators/>

my Mu $undef = Mu;  $undef.defined();

ok ?any(1..2), 'any(1..2) in boolean context';
ok !(any(0,0)), 'any(0,0) in boolean context';
ok !(one(1..2)), 'one(1..2) in boolean context';
ok ?(1|2), '1|2 in boolean context';
ok !(1^2), '1^2 in boolean context';
ok !($undef|0), 'undef|0 in boolean context';
ok !($undef|$undef), 'undef|undef in boolean context';
ok !($undef), 'undef in boolean context';
ok !(defined $undef), 'defined undef in boolean context';
ok !(all($undef, $undef)), 'all(undef, undef) in boolean context';
ok ?all(1,1), 'all(1,1) in boolean context';
ok !(all(1,$undef)), 'all(1,undef) in boolean context';

ok ?(1 | $undef), '1|undef in boolean context';
ok ?($undef | 1), 'undef|1 in boolean context';
ok !(1 & $undef), '1&undef in boolean context';
ok !($undef & 1), 'undef&1 in boolean context';
ok ?(1 ^ $undef), '1^undef in boolean context';
ok ?($undef ^ 1), 'undef^1 in boolean context';

ok ?(-1 | $undef), '-1|undef in boolean context';
ok ?($undef | -1), 'undef|-1 in boolean context';
ok !(-1 & $undef), '-1&undef in boolean context';
ok !($undef & -1), 'undef&-1 in boolean context';
ok ?(-1 ^ $undef), '-1^undef in boolean context';
ok ?($undef ^ -1), 'undef^-1 in boolean context';

#?DOES 3
{
(1|$undef && pass '1|undef in boolean context') || flunk '1|undef in boolean context';
(1 & $undef && flunk '1&undef in boolean context') || pass '1&undef in boolean context';
(1^$undef && pass '1^undef in boolean context') || flunk '1^undef in boolean context';
}

ok !(0 | $undef), '0|undef in boolean context';
ok !($undef | 0), 'undef|0 in boolean context';
ok !(0 & $undef), '0&undef in boolean context';
ok !($undef & 0), 'undef&0 in boolean context';
ok !(0 ^ $undef), '0^undef in boolean context';
ok !($undef ^ 0), 'undef^0 in boolean context';

{
    (0 | $undef && flunk '0|undef in boolean context') || pass '0|undef in boolean context';
    (0 & $undef && flunk '0&undef in boolean context') || pass '0&undef in boolean context';
    (0 ^ $undef && flunk '0^undef in boolean context') || pass '0^undef in boolean context';
}

my $message1 = 'boolean context collapses Junctions';
my $message2 = '...so that they\'re not Junctions anymore';
ok ?(Bool::True & Bool::False)    ==  Bool::False, $message1;
#?DOES 1
ok ?(Bool::True & Bool::False)    !~~ Junction,    $message2;
ok !(Bool::True & Bool::False)    ==  Bool::True,  $message1;
#?DOES 1
ok !(Bool::True & Bool::False)    !~~ Junction,    $message2;
#?rakudo todo 'named unary as function call'
ok so(Bool::True & Bool::False) ==  Bool::False, $message1;
ok (so Bool::True & Bool::False) !~~ Junction,    $message2;
ok ( not Bool::True & Bool::False)  ==  Bool::True,  $message1;
ok not(Bool::True & Bool::False)  !~~ Junction,    $message2;


ok do if 1 | 2 | 3 == 2 { 1 } else { 0 }, "3x very simple invocation of | and & in if";
ok do if 2 & 2 & 2 == 2 { 1 } else { 0 };
ok do if 2 & 2 & 2 == 3 { 0 } else { 1 };

#?niecza todo "Difficulties overloading | and &"
{
    my $foo = 0;
    sub infix:<|>(*@a) { $foo++; any(|@a) };
    sub infix:<&>(*@a) { $foo++; all(|@a) };
    ok do if 1 | 2 | 3 | 4 == 3 { 1 } else { 0 }, "4x local sub shadows | and &";
    is $foo, 1;
    ok do if 1 & 2 & 3 & 4 == 3 { 0 } else { 1 };
    is $foo, 2;
}

{
    my $count = 0;
    sub side-effect() { $count++ };
    ok do if side-effect() == 0 | 1 | 2 | 3 { 1 } else { 0 }, "6x side effect executed only once";
    is $count, 1;
    ok do if side-effect() == any(1, 2, 3) { 1 } else { 0 };
    is $count, 2;
    ok do if 1 | 2 | 3 | 4 == side-effect() { 1 } else { 0 };
    is $count, 3;
    ok do if any(1, 2, 3, 4) == side-effect() { 1 } else { 0 };
    is $count, 4;
}

{
    my $c = 0;
    for (-4..4)X(-4..4) -> $x, $y {
        if $x & $y == -1 | 0 | 1 {
            $c++;
        }
    }
    is $c, 9, "junctions on both sides of a comparison";
}

given 1 {
    when 0 | 1 | 2 {
        ok 1, "2x given + when";
    }
    when 3 | 4 | 5 {
        ok 0;
    }
}

{
    my $ctr = 0;
    while $ctr == 0 | 1 | 2 | 3 | 4 {
        $ctr++;
    }
    is $ctr, 5, "junction and while";
}

ok do if 5 & 6 & 7 <= 10 { 1 } else { 0 }, "using <=";

ok do if 5 < 3 | 5 | 10 { 1 } else { 0 }, "using <";

ok do if 3 & 5 & 6 != 4 { 1 } else { 0 }, "using !=";

ok do if 3 & 5 & 6 <= 5 | 10 { 1 } else { 0 }, "&, <= and |";

ok do if 1 | 2 | 3 <= 3 <= 5 { 1 } else { 0 }, "4x triple-chaining works";
ok do if 1 | 2 | 3 <= 3 <= 2 { 0 } else { 1 };
ok do if 1 <= 1 & 2 & 3 & 4 <= 4 { 1 } else { 0 };
ok do if 1 <= 1 & 2 & 3 & 4 <= 3 { 0 } else { 1 };

{
    my @a = 2, 3;
    ok do if any(1, @a, 4) == 3 { 1 } else { 0 }, "flattening in any works";
    ok do if all(1, @a, 4) <= 4 { 1 } else { 0 }, "flattening in all works";
    ok do if none(1, @a, 4) > 4 { 1 } else { 0 }, "flattening in none works";
}

# RT 117579
{
    ok do if 1 ne 2|3|4 { 1 } else { 0 }, "ne in if context";
    ok do if 1 ne 1|3|4 { 0 } else { 1 }, "ne in if context";

    my $invoc = 0;
    sub infix:<test>(Mu $a, Mu $b) { $invoc++; True };
    ok do if 1 test 2 | 3 | 4 | 5 { 1 } else { 0 }, "custom operator";
    is $invoc, 1, "operator with Mu argument doesn't get autothreaded.";
}

# vim: ft=perl6
