use v6;
use lib 't/spec/packages';

use Test;
use Test::Util;

plan 25;

dies_ok { Supply.migrate }, 'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new; 
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

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
        $master.more($s1);  # first get it from here

        $s1.more(42);
        $s1.more(43);
        is_deeply @seen, [42,43], 'did we get these?';

        my $s2 = Supply.new;
        ok $s2 ~~ Supply, 'Did we get a Supply 2?';
        $master.more($s2);  # now get it from here

        $s1.more(44);   # should not see this one
        $s2.more(666);
        $s2.more(667);
        $s2.more(668);
        is_deeply @seen, [42,43,666,667,668], 'did we get the rest?';

        $s2.done;
        my $s3 = Supply.new;
        ok $s3 ~~ Supply, 'Did we get a Supply 3?';
        $master.more($s3);  # now get it from here

        $s3.more(7);
        is_deeply @seen, [42,43,666,667,668,7], 'did we survive done?';

        throws_like { $master.more(23)}, X::Supply::Migrate::Needs;
    }
}
