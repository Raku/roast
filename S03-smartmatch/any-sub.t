use v6;
use Test;
plan 8;

#L<S03/Smart matching/Any .(...) sub call truth>
{
    my $t = sub { Bool::True };
    my $f = sub { Bool::False };
    my $mul = sub ($x) { $x * 2 };
    my $sub = sub ($x) { $x - 2 };

    ok ($t ~~ .()),     '~~ .() sub call truth (+)';
    ok !($f ~~ .()),    '~~ .() sub call truth (-)';
    ok  ('anything' ~~ $t), '~~ sub call truth (+)';
    ok !('anything' ~~ $f), '~~ sub call truth (-)';
    ok  (2 ~~ $mul),    '~~ sub call truth (+,1)';
    ok !(0 ~~ $mul),    '~~ sub call truth (-,1)';
    ok !(2 ~~ $sub),    '~~ sub call truth (+,2)';
    ok  (0 ~~ $sub),    '~~ sub call truth (-,2)';
}

# vim: ft=perl6
