use v6;

use Test;

plan 13;

# L<S03/"is divisible by">
{
    ok 6 %% 3, '6 %% 3';
    isa_ok 6 %% 3, Bool, '6 %% 3 isa Bool';
    nok 6 %% 4, '6 %% 4';
    isa_ok 6 %% 4, Bool, '6 %% 4 isa Bool';

    is (1..10).grep({ $_ %% 3 }), <3 6 9>, '%% works with explicit closure';
    is (1..10).grep( * %% 3 ), <3 6 9>, '%% works with whatever *';
}

{
    nok 6 !%% 3, '6 !%% 3';
    isa_ok 6 !%% 3, Bool, '6 !%% 3 isa Bool';
    ok 6 !%% 4, '6 !%% 4';
    isa_ok 6 %% 4, Bool, '6 !%% 4 isa Bool';

    is (1..10).grep({ $_ !%% 3 }), <1 2 4 5 7 8 10>, '%% works with explicit closure';
    is (1..10).grep( * !%% 3 ), <1 2 4 5 7 8 10>, '%% works with whatever *';
}

# RT #76170
{
    eval_dies_ok "say 9 !% 3", 'RT #76170'
}



