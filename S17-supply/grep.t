use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 13;

#?rakudo.jvm todo "D: doesn't work in signatures"
dies_ok { Supply.grep({...}) }, 'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(1..10).grep( * > 5 ),
      [6,7,8,9,10],
      "grepping taps works";
}
