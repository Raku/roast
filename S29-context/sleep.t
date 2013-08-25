use v6;
use Test;

# L<S29/Context/"=item sleep">

plan 12;

{
    diag "Sleeping for 3s";
    my $start = time;
    my $sleep_says = sleep 3;
    my $diff = time - $start;

    #?pugs todo
    ok( $sleep_says >= 2 , 'Sleep says it slept at least 2 seconds');
    ok( $sleep_says <= 10 , '... and no more than 10');

    ok( $diff >= 2 , 'We actually slept at least 2 seconds');
    ok( $diff <= 10 , '... and no more than 10');
} #4

#?pugs   skip "not yet implemented"
#?niecza todo "not yet implemented"
{
    is interval( 1.5 ), 0, "first call doesn't wait";
    my $start = time.Num;
    ok 0 <= interval(2.5) < 1.5, "first sleep";
    ok 0 <= interval(5  ) < 2.5, "second sleep";
    ok 0 <= interval(0  ) < 5  , "third sleep";
    is interval(3), 0, "fourth sleep";
    ok 0 <= interval(0  ) < 3  , "fifth sleep";
    ok 12 <= time.Num - $start <= 15, "some overall time";
} #7

#?pugs   todo "not yet implemented"
{
    dies_ok( { sleep(-1) }, "cannot go back in time" );
} #1

# vim: ft=perl6
