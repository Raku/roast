use v6;
use Test;

plan 4;

# https://github.com/Raku/old-issue-tracker/issues/2340
subtest 'signature binding outside of routine calls' => {
    plan 2;

    my ($f, $o, @a);
    @a = 2, 3, 4;
    :($f, $o, $) := @a;

    is $f, 2, 'f eq 2 after binding';
    is $o, 3, 'o eq 3 after binding';
};

# https://github.com/Raku/old-issue-tracker/issues/5110
subtest 'smartmatch on signatures with literals' => {
    plan 5;
    subtest 'strings' => {
        plan 5;
        is :("foo") ~~ :("bar"), False, ':D ~~ :D (false)';
        is :("bar") ~~ :("bar"), True,  ':D ~~ :D (true)';
        is :(Str)   ~~ :("foo"), False, ':U ~~ :D';
        is :("foo", "bar") ~~ :("bar", "bar"), False, ':D x 2 ~~ :D x2 (false)';
        is :("foo", "bar") ~~ :("foo", "bar"), True,  ':D x 2 ~~ :D x2 (true)';
    }
    subtest 'Complex' => {
        plan 5;
        is :(<1+1i>)  ~~ :(<1+2i>), False, ':D ~~ :D (false)';
        is :(<1+2i>)  ~~ :(<1+2i>), True,  ':D ~~ :D (true)';
        is :(Complex) ~~ :(<1+2i>), False, ':U ~~ :D';
        is :(<1+1i>, <1+2i>) ~~ :(<1+2i>, <1+2i>), False,
            ':D x 2 ~~ :D x2 (false)';
        is :(<1+1i>, <1+2i>) ~~ :(<1+1i>, <1+2i>), True,
          ':D x 2 ~~ :D x2 (true)';
    }
    subtest 'Rat' => {
        plan 5;
        #?rakudo 5 skip 'crashes'
        is :(<1.2>)    ~~ :(½), False, ':D ~~ :D (false)';
        is :(½)        ~~ :(½), True,  ':D ~~ :D (true)';
        is :(Rat)      ~~ :(½), False, ':U ~~ :D';
        is :(<1.2>, ½) ~~ :(½, ½),     False, ':D x 2 ~~ :D x2 (false)';
        is :(<1.2>, ½) ~~ :(<1.2>, ½), True,  ':D x 2 ~~ :D x2 (true)';
    }
    subtest 'Num' => {
        plan 5;
        is :(1e2) ~~ :(1e0), False, ':D ~~ :D (false)';
        is :(1e0) ~~ :(1e0), True,  ':D ~~ :D (true)';
        is :(Num) ~~ :(1e0), False, ':U ~~ :D';
        is :(1e2, 1e0) ~~ :(1e0, 1e0), False, ':D x 2 ~~ :D x2 (false)';
        is :(1e2, 1e0) ~~ :(1e2, 1e0), True,  ':D x 2 ~~ :D x2 (true)';
    }
    subtest 'Int' => {
        plan 5;
        is :(1)    ~~ :(2),    False, ':D ~~ :D (false)';
        is :(2)    ~~ :(2),    True,  ':D ~~ :D (true)';
        is :(Int)  ~~ :(2),    False, ':U ~~ :D';
        is :(1, 2) ~~ :(2, 2), False, ':D x 2 ~~ :D x2 (false)';
        is :(1, 2) ~~ :(1, 2), True,  ':D x 2 ~~ :D x2 (true)';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5503
eval-lives-ok ｢:($:)｣, 'invocant marker is allowed in bare signature';

# https://github.com/Raku/old-issue-tracker/issues/5507
is :(*%) ~~ :(), False, 'smartmatch with no slurpy on right side';

# vim: expandtab shiftwidth=4
