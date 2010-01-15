use v6;
use Test;
plan *;

#L<S03/Smart matching/Any .(...) sub call truth>
{
    my $t = sub { Bool::True };
    my $f = sub { Bool::False };
    my $mul = sub ($x) { $x * 2 };
    my $div = sub ($x) { $x - 2 };

    ok ($t ~~ .()),     '~~ .() sub call truth (+)';
    ok !($f ~~ .()),    '~~ .() sub call truth (-)';
    ok ($mul ~~ .(2)),  '~~ .($args) sub call truth (+,1)';
    ok !($mul ~~ .(0)), '~~ .($args) sub call truth (-,1)';
    ok !($div ~~ .(2)), '~~ .($args) sub call truth (+,2)';
    ok ($div ~~ .(0)),  '~~ .($args) sub call truth (-,2)';
}

done_testing;

# vim: ft=perl6
