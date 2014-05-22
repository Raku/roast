use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 12;

#?rakudo.jvm todo 'QAST::ParamTypeCheck needs to be implemented on jvm'
dies_ok { Supply.max }, 'can not be called as a class method';
dies_ok { Supply.new.max(23) }, 'must be code if specified';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(1..10).max, [1..10],
      "ascending max works";
    tap_ok Supply.for(10...1).max, [10],
      "descending max works";
    tap_ok Supply.for("a".."e","A".."E").max(*.uc), [<a b c d e>],
      "ascending alpha works";
    tap_ok Supply.for("E"..."A","e".."a").max(*.lc), ["E"],
      "decending alpha works";
}
