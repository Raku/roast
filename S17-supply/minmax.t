use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 10;

dies_ok { Supply.minmax }, 'can not be called as a class method';
dies_ok { Supply.new.minmax(23) }, 'must be code if specified';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.from-list(1..5).minmax, [(1..1),(1..2),(1..3),(1..4),(1..5)],
      "ascending minmax works";
    tap_ok Supply.from-list(5...1).minmax, [(5..5),(4..5),(3..5),(2..5),(1..5)],
      "descending minmax works";
    tap_ok Supply.from-list("a".."e","A".."E").minmax(*.uc),
      [("a".."a"),("a".."b"),("a".."c"),("a".."d"),("a".."e")],
      "ascending alpha works";
    tap_ok Supply.from-list("E"..."A","e".."a").minmax(*.lc),
      [("E".."E"),("D".."E"),("C".."E"),("B".."E"),("A".."E")],
      "descending alpha works";
}
