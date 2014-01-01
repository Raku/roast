use v6;
use Test;

plan 10;

# test \term
{
    sub identity(\x) { x }

    sub count(\x) {
        my $c = 0;
        ++$c for x;
        $c
    }

    sub swap(\x, \y) {
        my $z = y;
        y = x;
        x = $z;
    }

    is identity('foo'), 'foo',
       'basic passing of an argument to backslashed identifier';
    is count((1, 2, 3)), 3, 'passing of flattening arguments ';
    is count([1, 2, 3]), 1, 'passing of non-flatteing arguments';

    my $a = 5;
    my $b = 3;
    lives_ok { EVAL 'swap($a, $b)' }, 'backslash does not make read-only';
    is "$a|$b", '3|5', 'swapping worked';
    dies_ok { EVAL 'swap(42, $a)' }, 'no additional writable containers involved';
}

# test |term
{
    sub pass-on(&c, |args) { c(|args) }
    sub join-em(|args)     { args.list.join('|') }

    is pass-on(-> $a, $b { $a + $b }, 2, 3),  5,        '|args sanity (1)';
    is join-em('foo', 42),                    'foo|42', '|args sanity (2)';
    is join-em(pass-on(-> $a, $b { $a + $b }, 2, 3), 42),
       '5|42', 'combined sanity';

    is pass-on({ $:l~ $:w }, :w<6>, :l<p>), 'p6', 'named arguments';

}
