use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 10;

dies-ok { Supply.max }, 'can not be called as a class method';
dies-ok { Supply.new.max(23) }, 'must be code if specified';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).max, [1..10],
      "ascending max works";
    tap-ok Supply.from-list(10...1).max, [10],
      "descending max works";
    tap-ok Supply.from-list(flat("a".."e","A".."E")).max(*.uc), [<a b c d e>],
      "ascending alpha works";
    tap-ok Supply.from-list(flat("E"..."A","e".."a")).max(*.lc), ["E"],
      "descending alpha works";
}

# vim: expandtab shiftwidth=4
