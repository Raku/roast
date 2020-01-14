use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @source = <old dog>;
my @schedulers = ThreadPoolScheduler.new, CurrentThreadScheduler;

plan @schedulers * 1;

for @schedulers -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(@source).comb,
      [<o l d d o g>],
      "comb a simple list of words for characters";
}

# vim: ft=perl6 expandtab sw=4
