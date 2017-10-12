use v6.c;
use lib <t/spec/packages>;
use Test;
use Test::Util;

# This file is for random bugs that don't really fit well in other places
# or ones that need to be only part of strestest and not spectest.
# Feel free to move the tests to more appropriate places.

plan 2;

# RT #132042
doesn't-hang ｢
    my $fh = ｣ ~ make-temp-file.perl ~ ｢.open: :w;
    await ^20 .map: -> $t {
        start {
            for ^500 -> $i {
                my $current = %( 1 => %( 2 => %( 3 => %() ) ));
                my $index = 1;
                while $current{$index}:exists {
                    $fh.say: "$t $i $index";
                    $current = $current{$index};
                    ++$index;
                }
            }
        }
    }
    print 'pass';
｣, :5wait, :out<pass>, 'no deadlock while acquiring mutex';


# RT #132016
with Proc::Async.new: $*EXECUTABLE, '-e',
    ｢react whenever signal(SIGTERM).merge(signal SIGINT) { print ‘pass’; exit 0 }｣
-> $proc {
    my $out = ''; $proc.Supply.tap: { $out ~= $_ };
    my $p = $proc.start;
    await $proc.ready;
    Promise.in(%*ENV<ROAST_TIMING_SCALE>//1).then: {$proc.kill: SIGINT}; # give it a chance to boot up, then kill it
    await $p;
    is-deeply $out, 'pass', 'Supply.merge on signals does not crash';
}

# vim: expandtab shiftwidth=4 ft=perl6
