use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;

plan 4;

dies-ok { quietly { die 'not quiet enough' } }, '"die" in "quietly" dies';

is_run( 'quietly { warn "muted" }; say "detum"',
        { status => 0, err => '', out => "detum\n" },
        '"warn" in "quietly" does not warn, does not die' );

is_run( 'quietly { say "loud" }',
        { status => 0, err => '', out => "loud\n" },
        '"say" in "quietly" works fine' );

is_run( 'quietly { note "eton" }; say "life"',
        { status => 0, err => "eton\n", out => "life\n" },
        '"note" in "quietly" works' );

# vim: ft=perl6
