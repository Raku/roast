use v6;
use Test;
plan 20;

#L<S03/Smart matching/Range Range subset range>
{
    # .bounds.all ~~ X (mod ^'s)
    # means:
    # check whether both .min and .max are inside of the Range X
    # (though this is only true to a first approximation, as
    # those .min and .max values might be excluded)

    is-deeply 2..3 ~~ 1..4,     True,  'proper inclusion +';
    is-deeply 1..4 ~~ 2..3,     False, 'proper inclusion -';
    is-deeply 2..4 ~~ 1..4,     True,  'inclusive vs inclusive right end';
    is-deeply 2..^4 ~~ 1..4,    True,  'exclusive vs inclusive right end';
    is-deeply 2..4 ~~ 1..^4,    False, 'inclusive vs exclusive right end';
    is-deeply 2..^4 ~~ 1..^4,   True,  'exclusive vs exclusive right end';
    is-deeply 2..3 ~~ 2..4,     True,  'inclusive vs inclusive left end';
    is-deeply 2^..3 ~~ 2..4,    True,  'exclusive vs inclusive left end';
    is-deeply 2..3 ~~ 2^..4,    False, 'inclusive vs exclusive left end';
    is-deeply 2^..3 ~~ 2^..4,   True,  'exclusive vs exclusive left end';
    is-deeply 2..3 ~~ 2..3,     True,  'inclusive vs inclusive both ends';
    is-deeply 2^..^3 ~~ 2..3,   True,  'exclusive vs inclusive both ends';
    is-deeply 2..3 ~~ 2^..^3,   False, 'inclusive vs exclusive both ends';
    is-deeply 2^..^3 ~~ 2^..^3, True,  'exclusive vs exclusive both ends';
}

{
    is-deeply 1..Inf ~~ 1/0, True,  '1..Inf ~~ 1/0';
    is-deeply 2..4   ~~ 3,   True,  '2..4   ~~ 3';
    is-deeply 5..6   ~~ 5,   False, '5..6   ~~ 5';
}

skip 'cannot handle string ranges yet RT#130745', 3;
sub { # <-- can't figure out why the fudger hangs, so I wrapped it in a sub
subtest 'smartmatch against numeric range' => {
    constant fr2 = FatRat.new: 2, 1;
    constant fr3 = FatRat.new: 3, 1;
    constant @true  = 2..3,   '2'..'3', 2/1..3/1,   2..3,   2.5..2.8,
                    fr2..fr3,   2..fr3, 2e0..fr3, 2.5..fr3, fr3..fr3;
    constant @false = 1..3,   '2'..'4',  -2..5/1, -10..10,  2.5..6.5, 1^..3,
        '2'..^'4', '1'^..^3,  0/0..0/0, fr3..10, -2e0..fr2, 'a'..'z';
    constant @variants =     2..3,   2..3e0,   2..3.0,   2..fr3,
                           2e0..3, 2e0..3e0, 2e0..3.0, 2e0..fr3,
                           2.0..3, 2.0..3e0, 2.0..3.0, 2.0..fr3,
                           fr2..3, fr2..fr3, fr2..fr3, fr2..fr3;
    constant $plan = 2 + @variants * (@true + @false);
    is-deeply 3..4     ~~ -1/0..1/0, True,  '  3..4   ~~ -1/0..1/0';
    is-deeply 0/0..0/0 ~~ -1/0..1/0, False, '0/0..0/0 ~~ -1/0..1/0';

    for @variants -> $r {
        is-deeply $_ ~~ $r, True,  "{.perl} ~~ {$r.perl}" for @true;
        is-deeply $_ ~~ $r, False, "{.perl} ~~ {$r.perl}" for @false;
    }
}

subtest 'smartmatch of string ranges' => {
    my @true  = ['a'..'z', 'b'..'c'], ['aa'..'bb',  'a'..'z' ],
                ['♥'..'♦', '♥'..'♦'], ['♥0'..'♦3', '♥0'..'♦3'];
    my @false = ['b'..'c', 'a'..'z'], ['aa'..'bb',  'b'..'z' ],
                ['♤'..'♦', '♥'..'♦'], ['♤0'..'♦3', '♥0'..'♦3'];
    plan @true + @false;

    for @true -> ($a, $b) {
        is-deeply $a ~~ $b, True,  "{$a.perl} ~~ {$b.perl}";
    }
    for @false -> ($a, $b) {
        is-deeply $a ~~ $b, False, "{$a.perl} ~~ {$b.perl}";
    }
}

subtest 'smartmatch numeric range against string range [numeric strings]' => {
    # Note: numeric `10` in tests below should be compared as a string by
    # the smartmatch against a string range, and so it *is* correct that
    # 0..10 ~~ '0'..'3' === True, since string '10' is before '3' and after '0'
    constant fr0  = FatRat.new:  0, 1; constant fr3  = FatRat.new:  3, 1;
    constant fr10 = FatRat.new: 10, 1; constant fr30 = FatRat.new: 30, 1;
    constant @true  = 0..10,   0..fr10,   0..10e0,   0..10.0,   0..10/1,
                    0e0..10, fr0..fr10, 0.0..10e0, 0e0..10.0, 0e0..10/1;
    constant @false = 0..30,   0..fr30,   0..30e0,   0..30.0,   0..30/1,
                    0e0..30, fr0..fr30, 0.0..30e0, 0e0..30.0, 0e0..30/1;
    constant @variants = '0'..3,   '0'..3.0, '0'..3e0, '0'..fr3,
                           0..'3', 0.0..'3', 0e0..'3', fr0..'3';
    constant $plan = @variants * (@true + @false);

    for @variants -> $r {
        is-deeply $_ ~~ $r, True,  "{.perl} ~~ {$r.perl}" for @true;
        is-deeply $_ ~~ $r, False, "{.perl} ~~ {$r.perl}" for @false;
    }
}

} # <-- end of skip fudge wrapper

# vim: ft=perl6
