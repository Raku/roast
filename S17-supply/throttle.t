use v6;
use lib 't/spec/packages';

use Test;

plan 7;

dies-ok { Supply.throttle(1,1) }, 'can not be called as a class method';

for ThreadPoolScheduler.new -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $min = 0;
        my $max = 10;
        my @seen;
        my $before = now;
        (1..10).Supply.throttle(1,.5).tap: {
            @seen.push($_);
            my $diff = now - $before;
            $max     = $max min now - $before;
            $min     = $min max now - $before;
            $before  = now;
        };
        sleep 6;
        is @seen, (1..10), 'did we see all of the element';
        ok $min > .5, 'difference between each at least .5 seconds';
        ok $max < .6, 'difference between each at most .6 seconds';
    }

    {
        my $min = 0;
        my $max = 10;
        my @seen;
        my $control = Supply.new;
        my $before = now;
        (1..10).Supply.throttle(0,.5,:$control).tap: {
            @seen.push($_);
            my $diff = now - $before;
            $max     = $max min now - $before;
            $min     = $min max now - $before;
            $before  = now;
        };
        sleep 1;
        $control.emit( (limit => 2) );
        sleep 3;
        is @seen, (1..10), 'did we see all of the element';
        ok $min >  0, 'difference between each at least something';
        ok $max < .3, 'difference between each at most .3 seconds';
    }
}
