use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;
use Test::Util;

plan 4;

dies-ok { Supply.new.interval(1) }, 'can not be called as an instance method';

{
    tap-ok Supply.interval(1),
      [^5],
      'interval of 1 second',
      :after-tap( { sleep 4.5 } );
}

{
    tap-ok Supply.interval(1, 2),
      [^3],
      'interval of 1 second with delay of 2',
      :after-tap( { sleep 4.5 } );
}

# RT #125621
is_run(
       'my $timer = Supply.interval(0.1); $timer.tap({ die "uh-oh" }); sleep 2;',
       { status => * != 0, err => /"uh-oh"/},
       'Exception thrown in a timer and unhandled terminates program',
);
