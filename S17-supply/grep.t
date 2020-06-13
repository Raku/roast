use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 9;

dies-ok { Supply.grep({...}) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).grep( * > 5 ),
      [6,7,8,9,10],
      "grepping taps with a Callable works";

    tap-ok Supply.from-list(flat(1..10,"a".."z")).grep(Int),
      [1..10],
      "grepping taps with a Type works";

    tap-ok Supply.from-list("a".."z").grep(/<[a..e]>/),
      ["a".."e"],
      "grepping taps with a Regex works";

    # https://github.com/Raku/old-issue-tracker/issues/5060
    tap-ok Supply.from-list(<foo bar foobar>).grep(/foo/).grep(/bar/),
      ['foobar'],
      "second grep only gets the results of the first";
}

# vim: expandtab shiftwidth=4
