use v6.c;

use Test;

plan 4;

dies-ok { Supply.wait }, 'can not be called as a class method';

{
    my $s = Supplier.new;
    isa-ok start {
        sleep 1;
        pass "we're running";
        sleep 1;
        $s.emit($_) for 1..10;
        $s.done;
    }, Promise, 'did we start ok';
    my $waiting = now;
    $s.Supply.wait;
    ok $waiting + 2 < now, "did we wait long enough?";
}

# vim: ft=perl6 expandtab sw=4
