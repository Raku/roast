use v6;
use Test;

plan 1;

# RT #82946
subtest 'signature binding outside of routine calls' => {
    plan 2;

    my ($f, $o, @a);
    @a = 2, 3, 4;
    :($f, $o, $) := @a;

    is $f, 2, 'f eq 2 after binding';
    is $o, 3, 'o eq 3 after binding';
};

# vim: ft=perl6
