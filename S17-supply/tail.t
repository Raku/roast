use v6.c;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 8;

dies-ok { Supply.tail }, 'can not be called as a class method';
dies-ok { Supply.new.tail("foo") }, 'cannot have "foo" tail';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(1..10).tail, [10], "tail without argument works";
    tap-ok Supply.from-list(1..10).tail(5), [6..10], "tail five works";
    tap-ok Supply.from-list(1..10).tail(15), [1..10], "tail 15 works";
}

# vim: ft=perl6 expandtab sw=4
