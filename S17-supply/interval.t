use v5;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 3;

dies_ok { Supply.new.interval(1) }, 'can not be called as an instance method';

{
    tap_ok Supply.interval(1),
      [^5],
      'interval of 1 second',
      :after-tap( { sleep 4.5 } );
}

{
    tap_ok Supply.interval(1, 2),
      [^3],
      'interval of 1 second with delay of 2',
      :after-tap( { sleep 4.5 } );
}
