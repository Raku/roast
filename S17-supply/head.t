use v6.c;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 8;

dies-ok { Supply.head }, 'can not be called as a class method';
dies-ok { Supply.new.head("foo") }, 'cannot have "foo" head';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(1..10).head, [1,], "head without argument works";
    tap-ok Supply.from-list(1..10).head(5), [1..5], "head five works";
    tap-ok Supply.from-list(1..10).head(15), [1..10], "head 15 works";
}

# vim: ft=perl6 expandtab sw=4
