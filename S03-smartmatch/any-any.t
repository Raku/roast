use v6;
use Test;
plan *;

#L<S03/Smart matching/Any Any scalars are identical>
{
    class Smartmatch::ObjTest {}
    my $a = Smartmatch::ObjTest.new;
    my $b = Smartmatch::ObjTest.new;
    ok  ($a ~~  $a),    'Any ~~  Any (+)';
    ok !($a !~~ $a),    'Any !~~ Any (-)';
    ok !($a ~~  $b),    'Any ~~  Any (-)';
    ok  ($a !~~ $b),    'Any !~~ Any (+)';
}

done_testing;

# vim: ft=perl6
