use v6;

use Test;

plan 5;

dies-ok { Supply.wait }, 'can not be called as a class method';

{
    my $s = Supplier.new;
    my $waiting = now;
    isa-ok start {
        sleep 1;
        pass "we're running";
        sleep 1;
        $s.emit($_) for 1..10;
        $s.done;
    }, Promise, 'did we start ok';
    $s.Supply.wait;
    ok $waiting + 2 < now, "did we wait long enough?";
}

# RT #129247
{
    my $supplier = Supplier.new;
    my $supply   = $supplier.Supply;

    my @emitted;
    $supply.tap: { @emitted.push($_) }
    $supply.tap: { @emitted.push($_) }
    start {
        $supplier.emit(1);
        sleep 1;
        $supplier.emit(2);
        $supplier.done;
    }
    $supply.wait;

    is-deeply @emitted, [1, 1, 2, 2], '.wait on tapped supply';
}

# vim: ft=perl6 expandtab sw=4
