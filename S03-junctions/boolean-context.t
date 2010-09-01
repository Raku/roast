use v6;
use Test;
plan 45;

# L<S03/Junctive operators/>

my $undef = Mu;  $undef.defined();

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

#?DOES 1
#?rakudo skip 'Mu and =='
ok ?(0|$undef == 0), '0|undef == 0 in boolean context';

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

# vim: ft=perl6
