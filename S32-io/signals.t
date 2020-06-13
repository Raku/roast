use Test;

plan 1;

my Signal:D @signals = Signal.enums.values.grep(* > 0).map({ Signal($_) });

unless +@signals {
    skip-rest "no valid signals were found on this platform ({$*KERNEL.osname})";
    exit 1;
};

subtest '&signal', {
    plan 4;

    # R#3035
    {
        my Signal:D $head = @signals.head;
        my Signal:D $tail = @signals.tail;

        lives-ok {
            signal($head, $tail);
        }, 'can be invoked with two separate signals';
        lives-ok {
            signal($head, ($tail,));
        }, 'can be invoked with a signal and a list of signals';
        lives-ok {
            signal(($head,), $tail);
        }, 'can be invoked with a list of signals and a signal';
        lives-ok {
            signal(($head, $tail));
        }, 'can be invoked with a list of signals';
    }
};

# vim: expandtab shiftwidth=4
