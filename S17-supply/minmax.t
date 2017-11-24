use v6;
use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Tap;

plan 10;

dies-ok { Supply.minmax }, 'can not be called as a class method';
dies-ok { Supply.new.minmax(23) }, 'must be code if specified';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(1..5).minmax, [(1..1),(1..2),(1..3),(1..4),(1..5)],
      "ascending minmax works";
    tap-ok Supply.from-list(5...1).minmax, [(5..5),(4..5),(3..5),(2..5),(1..5)],
      "descending minmax works";
    tap-ok Supply.from-list(flat("a".."e","A".."E")).minmax(*.uc),
      [("a".."a"),("a".."b"),("a".."c"),("a".."d"),("a".."e")],
      "ascending alpha works";
    tap-ok Supply.from-list(reverse(flat "a".."e","A".."E")).minmax(*.lc),
      [("E".."E"),("D".."E"),("C".."E"),("B".."E"),("A".."E")],
      "descending alpha works";
}

# vim: ft=perl6 expandtab sw=4
