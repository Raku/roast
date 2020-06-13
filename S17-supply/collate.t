use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;
use Test::Util;

plan 7;

is-eqv Supply.collate, (Supply,).Seq, 'can sort a Supply type object';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    #?rakudo.jvm 3 todo 'dies in LAST block in method grab: Cannot resolve caller infix:<coll>(Int:D, Int:D); none of these signatures match: (Str:D \a, Str:D \b)'
    tap-ok Supply.from-list(10...1).collate, [1,10,2,3,4,5,6,7,8,9],
      "we can collate numbers (always treated as strings)";
    tap-ok Supply.from-list("z"..."a").collate, ["a" .. "z"],
      "we can collate strings";
    tap-ok Supply.from-list(flat("a".."d", "A" .. "D")).collate,
      [<a A b B c C d D>],
      "we can collate mixed case";
}

# vim: expandtab shiftwidth=4
