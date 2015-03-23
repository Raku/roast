use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 10;

dies_ok { Supply.max }, 'can not be called as a class method';
dies_ok { Supply.new.max(23) }, 'must be code if specified';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.from-list(1..10).max, [1..10],
      "ascending max works";
    tap_ok Supply.from-list(10...1).max, [10],
      "descending max works";
    tap_ok Supply.from-list("a".."e","A".."E").max(*.uc), [<a b c d e>],
      "ascending alpha works";
    tap_ok Supply.from-list("E"..."A","e".."a").max(*.lc), ["E"],
      "descending alpha works";
}
