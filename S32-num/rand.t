use v6;

use Test;

plan 113;

=begin pod

Basic tests for the rand builtin

=end pod

# L<S32::Numeric/Numeric/"=item rand">

ok(rand >= 0, 'rand returns numbers greater than or equal to 0');
ok(rand < 1, 'rand returns numbers less than 1');

sub test_rand_range(Int $num) {
  for 1..20 {
    my $result = $num.rand;
    ok($num > $result >= 0, "rand returns numbers in [0, $num)");
  }
}

test_rand_range(2);
test_rand_range(3);
test_rand_range(5);
test_rand_range(7);
test_rand_range(11);

# L<S32::Numeric/Real/"=item srand">

lives_ok { srand(1) }, 'srand(1) lives and parses';

{
    my sub repeat_rand ($seed) {
        srand($seed);
        for 1..99 { rand; }
        return rand;
    }

    ok(repeat_rand(314159) == repeat_rand(314159),
        'srand() provides repeatability for rand');

    ok(repeat_rand(0) == repeat_rand(0),
        'edge case: srand(0) provides repeatability');

    ok(repeat_rand(0) != repeat_rand(1),
        'edge case: srand(0) not the same as srand(1)');
}

{
    my sub repeat_rand ($seed) {
        srand($seed);
        for 1..99 { rand; }
        return rand;
    }

    ok(repeat_rand(314159) == repeat_rand(314159),
        'srand(...) provides repeatability for rand');

    ok(repeat_rand(0) == repeat_rand(0),
        'edge case: srand(0) provides repeatability');

    ok(repeat_rand(0) != repeat_rand(1),
        'edge case: srand(0) not the same as srand(:seed(1))');
}

#?rakudo skip 'Test is too slow'
#?niecza skip 'Test is too slow'
# Similar code under Perl 5 runs in < 15s.
{
    srand;

    my $cells = 2 ** 16;                 # possible values from rand()
    my $samples = 500 * $cells;          # how many rand() calls we'll make
    my $freq_wanted = $samples / $cells; # ideal samples per cell
#    my @freq_observed[$cells];
    my @freq_observed;

    @freq_observed[ $cells.rand ]++ for 1 .. $samples;

    my $cs = 0;
    for @freq_observed -> $obsfreq {
        $cs += (($obsfreq // 0) - $freq_wanted) ** 2;
    }
    $cs /= $freq_wanted;

    my $badness = abs( 1 - $cs / ( $cells - 1 ) );

    # XXX: My confidence in this test is rather low.
    # I got the number below by running the same test repeatedly with Perl 5
    # and observing its results then again with deliberately corrupted
    # "results".  The value I picked is between the worst of the natural
    # results and the best of the b0rked results.
    # My hope is that someone who understands Chi Squared tests
    # better than I do will find what I've written easier to fix
    # than to write a good test from scratch.
    # The good news is it passes with Rakudo when I cut down on $samples
    # and wait a while.

    ok( $badness < 0.15, 'rand is pretty random' );
}

{
    # this catches if the random number generator is biased toward
    # smaller numbers in a range.
    my %h;
    %h{$_}++ for (^5).roll(1000);
    ok %h<3> + %h<4> > 300, "Distribution is not very uneven";
}

# RT #113968
#?niecza skip "throws_like"
#?DOES 4
{
    throws_like 'rand()', X::Obsolete;
    throws_like 'rand(3)', X::Obsolete;
}

done;

# vim: ft=perl6
