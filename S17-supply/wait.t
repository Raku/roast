use v6;

use Test;

plan 4;

dies_ok { Supply.wait }, 'can not be called as a class method';

{
    my $s = Supply.new;
    isa_ok start( {
        sleep 1;
        pass "we're running";
        sleep 1;
        $s.emit($_) for 1..10;
        $s.done;
    } ), Promise, 'did we start ok';
    my $waiting = now;
    $s.wait;
    ok $waiting + 2 < now, "did we wait long enough?";
}
