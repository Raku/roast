use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 44;

dies_ok { Supply.min }, 'can not be called as a class method';
dies_ok { Supply.new.min(23) }, 'must be code if specified';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(1..10).min, [1],
      "ascending min works";
    tap_ok Supply.for(10...1).min, [10...1],
      "descending min works";
    tap_ok Supply.for("a".."e","A".."E").min(*.uc), ["a"],
      "ascending alpha works";
    tap_ok Supply.for("E"..."A","e".."a").min(*.lc), [<E D C B A>],
      "decending alpha works";
}
