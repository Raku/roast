use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;
use Test::Util;

plan 4;

dies-ok { Supplier.new.Supply.interval(1) }, 'can not be called as an instance method';

{
    my $scheduler = FakeScheduler.new;
    tap-ok Supply.interval(1, :$scheduler),
      [^5],
      'interval of 1 second',
      :after-tap( { $scheduler.progress-by(Duration.new(4.5)) } ),
      :virtual-time;
}

{
    my $scheduler = FakeScheduler.new;
    tap-ok Supply.interval(1, 2, :$scheduler),
      [^3],
      'interval of 1 second with delay of 2',
      :after-tap( { $scheduler.progress-by(Duration.new(4.5)) } ),
      :virtual-time;
}

# RT #125621
is_run(
       'my $timer = Supply.interval(0.1); $timer.tap({ die "uh-oh" }); sleep 5;',
       { status => * != 0, err => /"uh-oh"/},
       'Exception thrown in a timer and unhandled terminates program',
);

# vim: ft=perl6 expandtab sw=4
