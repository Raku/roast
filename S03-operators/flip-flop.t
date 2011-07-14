use v6;

use Test;

plan 39;

# L<S03/Changes to Perl 5 operators/flipflop operator is now done with>


# Basic ff
{
    $_ = "1";
    ok (1 ff 1), 'flip-flop operator implemented';
    ok (1 fff 1), 'fff operator implemented';
}


# test basic flip-flop operation
{

    sub test_ff($code, @a) {
        my $ret = '';
        for @a {
            $ret ~= $code.($_) ?? $_ !! 'x';
        }
        return $ret;
    }

    is test_ff({/B/ ff /D/   }, <A B C D E>), 'xBCDx', '/B/ ff /D/, lhs != rhs';
    is test_ff({/B/ ^ff /D/  }, <A B C D E>), 'xxCDx', '/B/ ^ff /D/, lhs != rhs';
    is test_ff({/B/ ff^ /D/  }, <A B C D E>), 'xBCxx', '/B/ ff^ /D/, lhs != rhs';
    is test_ff({/B/ ^ff^ /D/ }, <A B C D E>), 'xxCxx', '/B/ ^ff^ /D/, lhs != rhs';
    is test_ff({/B/ fff /D/  }, <A B C D E>), 'xBCDx', '/B/ fff /D/, lhs != rhs';
    is test_ff({/B/ ^fff /D/ }, <A B C D E>), 'xxCDx', '/B/ ^fff /D/, lhs != rhs';
    is test_ff({/B/ fff^ /D/ }, <A B C D E>), 'xBCxx', '/B/ fff^ /D/, lhs != rhs';
    is test_ff({/B/ ^fff^ /D/}, <A B C D E>), 'xxCxx', '/B/ ^fff^ /D/, lhs != rhs';

    is test_ff({/B/ ff /B/   }, <A B A B A>), 'xBxBx', '/B/ ff /B/, lhs == rhs';
    is test_ff({/B/ ^ff /B/  }, <A B A B A>), 'xxxxx', '/B/ ^ff /B/, lhs == rhs';
    is test_ff({/B/ ff^ /B/  }, <A B A B A>), 'xxxxx', '/B/ ff^ /B/, lhs == rhs';
    is test_ff({/B/ ^ff^ /B/ }, <A B A B A>), 'xxxxx', '/B/ ^ff^ /B/, lhs == rhs';
    is test_ff({/B/ fff /B/  }, <A B A B A>), 'xBABx', '/B/ fff /B/, lhs == rhs';
    is test_ff({/B/ ^fff /B/ }, <A B A B A>), 'xxABx', '/B/ ^fff /B/, lhs == rhs';
    is test_ff({/B/ fff^ /B/ }, <A B A B A>), 'xBAxx', '/B/ fff^ /B/, lhs == rhs';
    is test_ff({/B/ ^fff^ /B/}, <A B A B A>), 'xxAxx', '/B/ ^fff^ /B/, lhs == rhs';

    is test_ff({/B/ ff *     }, <A B C D E>), 'xBCDE', '/B/ ff *';
}


# test flip-flop sequence management
{
    sub test_ff_cnt($code, @a) {
        my $ret = '';
        for @a {
            my $i;
            $ret ~= (($i = $code.($_)) ?? $_ !! 'x') ~ $i;
        }
        return $ret;
    }

    is test_ff_cnt({/B/ ff /D/   }, <A B C D E>), 'xB1C2D3x', '/B/ ff /D/, seq #s, lhs != rhs';
    is test_ff_cnt({/B/ ^ff /D/  }, <A B C D E>), 'xxC2D3x', '/B/ ^ff /D/, seq #s, lhs != rhs';
    is test_ff_cnt({/B/ ff^ /D/  }, <A B C D E>), 'xB1C2xx', '/B/ ff^ /D/, seq #s, lhs != rhs';
    is test_ff_cnt({/B/ ^ff^ /D/ }, <A B C D E>), 'xxC2xx', '/B/ ^ff^ /D/, seq #s, lhs != rhs';
    is test_ff_cnt({/B/ fff /D/  }, <A B C D E>), 'xB1C2D3x', '/B/ fff /D/, seq #s, lhs != rhs';
    is test_ff_cnt({/B/ ^fff /D/ }, <A B C D E>), 'xxC2D3x', '/B/ ^fff /D/, seq #s, lhs != rhs';
    is test_ff_cnt({/B/ fff^ /D/ }, <A B C D E>), 'xB1C2xx', '/B/ fff^ /D/, seq #s, lhs != rhs';
    is test_ff_cnt({/B/ ^fff^ /D/}, <A B C D E>), 'xxC2xx', '/B/ ^fff^ /D/, seq #s, lhs != rhs';

    is test_ff_cnt({/B/ ff /B/   }, <A B A B A>), 'xB1xB1x', '/B/ ff /B/, seq #s, lhs == rhs';
    is test_ff_cnt({/B/ ^ff /B/  }, <A B A B A>), 'xxxxx', '/B/ ^ff /B/, seq #s, lhs == rhs';
    is test_ff_cnt({/B/ ff^ /B/  }, <A B A B A>), 'xxxxx', '/B/ ff^ /B/, seq #s, lhs == rhs';
    is test_ff_cnt({/B/ ^ff^ /B/ }, <A B A B A>), 'xxxxx', '/B/ ^ff^ /B/, seq #s, lhs == rhs';
    is test_ff_cnt({/B/ fff /B/  }, <A B A B A>), 'xB1A2B3x', '/B/ fff /B/, seq #s, lhs == rhs';
    is test_ff_cnt({/B/ ^fff /B/ }, <A B A B A>), 'xxA2B3x', '/B/ ^fff /B/, seq #s, lhs == rhs';
    is test_ff_cnt({/B/ fff^ /B/ }, <A B A B A>), 'xB1A2xx', '/B/ fff^ /B/, seq #s, lhs == rhs';
    is test_ff_cnt({/B/ ^fff^ /B/}, <A B A B A>), 'xxA2xx', '/B/ ^fff^ /B/, seq #s, lhs == rhs';
}


# See thread "till (the flipflop operator, formerly ..)" on p6l started by Ingo
# Blechschmidt, especially Larry's reply:
# http://www.nntp.perl.org/group/perl.perl6.language/24098
# make sure calls to external sub uses the same ff each time
{
    sub check_ff($i) {
        $_ = $i;
        return (/B/ ff /D/) ?? $i !! 'x';
    }

    my $ret = "";
    $ret ~= check_ff('A');
    $ret ~= check_ff('B');
    $ret ~= check_ff('C');
    $ret ~= check_ff('D');
    $ret ~= check_ff('E');
    is $ret, 'xBCDx', 'calls from different locations use the same ff';
}

# From the same thread, making sure that clones get different states
{
    my $ret = "";
    for 0,1 {
        sub check_ff($_) { (/B/ ff /D/) ?? $_ !! 'x' }
        $ret ~= check_ff('A');
        $ret ~= check_ff('B');
        $ret ~= check_ff('C');
    }
    is $ret, 'xBCxBC', 'different clones of the sub get different ff'
}

# make sure {lhs,rhs} isn't evaluated when state is {true,false}
{

    # keep track of # of times lhs and rhs are eval'd by adding
    # a state var to both sides.
    sub ff_eval($code, $lhs, $rhs, @a) {
        my $lhs_run = 0;
        my $rhs_run = 0;

        for @a { $code.({$lhs_run++; ?$lhs}, {$rhs_run++; ?$rhs}); }

        return [$lhs_run, $rhs_run];
    }

    is_deeply ff_eval({@_[0]() ff @_[1]()}, /B/, /B/, <A B A B A>),
        [5, 2], "count lhs & rhs evals for ff";

    is_deeply ff_eval({@_[0]() fff @_[1]()}, /B/, /B/, <A B A B A>),
        [3, 2], "count lhs & rhs evals for fff";
}

done;

# vim: ft=perl6
