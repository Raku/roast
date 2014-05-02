use v6;
use Test;
use lib 't/spec/packages';
use Test::Util;

dies_ok { quietly { die 'not quiet enough' } }, '"die" in "quietly" dies';

is_run( 'quietly { warn "muted" }; say "detum"',
        { status => 0, err => '', out => "detum\n" },
        '"warn" in "quietly" does not warn, does not die' );

is_run( 'quietly { say "loud" }',
        { status => 0, err => '', out => "loud\n" },
        '"say" in "quietly" works fine' );

is_run( 'quietly { note "eton" }; say "life"',
        { status => 0, err => "eton\n", out => "life\n" },
        '"note" in "quietly" works' );

done;

# vim: ft=perl6
