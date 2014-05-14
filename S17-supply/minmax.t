use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 12;

dies_ok { Supply.minmax }, 'can not be called as a class method';
dies_ok { Supply.new.minmax(23) }, 'must be code if specified';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(1..5).minmax, [(1..1),(1..2),(1..3),(1..4),(1..5)],
      "ascending minmax works";
    tap_ok Supply.for(5...1).minmax, [(5..5),(4..5),(3..5),(2..5),(1..5)],
      "descending minmax works";
    tap_ok Supply.for("a".."e","A".."E").minmax(*.uc),
      [("a".."a"),("a".."b"),("a".."c"),("a".."d"),("a".."e")],
      "ascending alpha works";
    tap_ok Supply.for("E"..."A","e".."a").minmax(*.lc),
      [("E".."E"),("D".."E"),("C".."E"),("B".."E"),("A".."E")],
      "decending alpha works";
}
