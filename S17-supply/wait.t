use v6;
use lib 't/spec/packages';

use Test;

plan 3;

{
    my $s = Supply.new;
    isa_ok start( {
        sleep 1;
        pass "we're running";
        sleep 1;
        $s.more($_) for 1..10;
        $s.done;
    } ), Promise, 'did we start ok';
    my $waiting = now;
    $s.wait;
    ok $waiting + 2 < now, "did we wait long enough?";
}
