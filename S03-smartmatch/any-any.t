use v6;
use Test;
plan 8;

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


{
    $_ = 42;
    my $x;
    'abc' ~~ ($x = $_);
    is $x, 'abc', '~~ sets $_ to the LHS';
    is $_, 42, 'original $_ restored';
    'defg' !~~ ($x = $_);
    is $x, 'defg', '!~~ sets $_ to the LHS';
    is $_, 42, 'original $_ restored';
    'defg' !~~ ($x = $_);
}

done;

# vim: ft=perl6
