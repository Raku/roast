use v6;

use Test;
plan 21;

dies_ok { Supply.migrate }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $master = Supply.new;
        ok $master ~~ Supply, 'Did we get a master Supply?';
        my $migrate = $master.migrate;
        ok $migrate ~~ Supply, 'Did we get a migrate Supply?';

        my @seen;
        my $tap = $migrate.tap( { @seen.push: $_ } );
        isa_ok $tap, Tap, 'Did we get a Tap';

        my $s1 = Supply.new;
        ok $s1 ~~ Supply, 'Did we get a Supply 1?';
        $master.emit($s1);  # first get it from here

        $s1.emit(42);
        $s1.emit(43);
        is_deeply @seen, [42,43], 'did we get these?';

        my $s2 = Supply.new;
        ok $s2 ~~ Supply, 'Did we get a Supply 2?';
        $master.emit($s2);  # now get it from here

        $s1.emit(44);   # should not see this one
        $s2.emit(666);
        $s2.emit(667);
        $s2.emit(668);
        is_deeply @seen, [42,43,666,667,668], 'did we get the rest?';

        $s2.done;
        my $s3 = Supply.new;
        ok $s3 ~~ Supply, 'Did we get a Supply 3?';
        $master.emit($s3);  # now get it from here

        $s3.emit(7);
        is_deeply @seen, [42,43,666,667,668,7], 'did we survive done?';

        throws_like { $master.emit(23)}, X::Supply::Migrate::Needs;
    }
}

# vim: syn=perl6
