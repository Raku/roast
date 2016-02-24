use v6.c;

use Test;
plan 13;

dies-ok { Supply.migrate }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $master = Supplier.new;
        my $migrate = $master.Supply.migrate;
        ok $migrate ~~ Supply, 'Did we get a migrate Supply?';

        my @seen;
        my $tap = $migrate.tap( { @seen.push: $_ } );
        isa-ok $tap, Tap, 'Did we get a Tap';

        my $s1 = Supplier.new;
        $master.emit($s1.Supply);  # first get it from here

        $s1.emit(42);
        $s1.emit(43);
        is-deeply @seen, [42,43], 'did we get these?';

        my $s2 = Supplier.new;
        $master.emit($s2.Supply);  # now get it from here

        $s1.emit(44);   # should not see this one
        $s2.emit(666);
        $s2.emit(667);
        $s2.emit(668);
        is-deeply @seen, [42,43,666,667,668], 'did we get the rest?';

        $s2.done;
        my $s3 = Supplier.new;
        $master.emit($s3.Supply);  # now get it from here

        $s3.emit(7);
        is-deeply @seen, [42,43,666,667,668,7], 'did we survive done?';

        throws-like { $master.emit(23)}, X::Supply::Migrate::Needs;
    }
}

# vim: ft=perl6 expandtab sw=4
