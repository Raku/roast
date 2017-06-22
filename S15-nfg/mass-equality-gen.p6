#!/usr/bin/env perl6
constant EQUALITY_TEST_CASES = 500;

sub MAIN(Str $unidata-normalization-tests) {
    # Parse the normalization test data, and gather those cases where the NFC
    # form contains a non-starter (Canonical_Combining_Class > 0).
    my @targets = my ($source, $nfc, $nfd, $nfkc, $nfkd) = [] xx 5;
    for $unidata-normalization-tests.IO.lines {
        next if /^['#'|'@'|\s+$]/;
        my @pieces = .split(';')[^5];
        my @nfc-codes = @pieces[1].split(' ').map({ :16($_) });
        next if @nfc-codes < 2;
        for @nfc-codes -> $code {
            if ccc($code) > 0 {
                .push(@pieces.shift) for @targets;
                last;
            }
        }
    }
    say "Found $source.elems() interesting cases for NFG tests.";

    # Write tests.
    write-equality-test-file('S15-nfg/mass-equality.t', $nfd, EQUALITY_TEST_CASES);
}

sub write-equality-test-file($target, @nfd, $limit) {
    given open($target, :w) {
        .say: qq:to/HEADER/;
use v6;
# Normal Form Grapheme equanity tests, generated from NormalizationTests.txt in
# the Unicode database by S15-nfg/mass-equality-gen.p6. Check strings that should come
# out equal under NFG do, and strings that are "tempting" to make equal but
# should not be don't. The "should not be" falls out of the definition of NFD,
# of note the notion of blocked swaps in canonical sorting.

use Test;

plan $limit;
HEADER

        for @nfd -> $nfd {
            # Look for cases where we have two distinct non-starters in a row.
            my @codes = $nfd.split(' ').map({ :16($_) });
            my @swap  = @codes;
            my $test = 'is';
            loop (my $i = 0; $i < @codes - 1; $i++) {
                my $ccc1 = ccc(@codes[$i]);
                my $ccc2 = ccc(@codes[$i + 1]);
                if $ccc1 & $ccc2 > 0 && @codes[$i] != @codes[$i + 1] {
                    # Swap the two non-starters. If they have an equal ccc
                    # then they should test unequal.
                    @swap[$i, $i + 1] = @swap[$i + 1, $i];
                    $test = 'isnt' if $ccc1 == $ccc2;
                    $i++; # don't swap with next thing also
                }
            }
            my $hexy-swapped = @swap.map('0x' ~ *.base(16)).join(', ');
            my $hexy-nfd     = hexy($nfd);
            .say: "$test Uni.new($hexy-nfd).Str, Uni.new($hexy-swapped).Str, '$hexy-nfd vs. $hexy-swapped';";
            last if ++$ == $limit;
        }

        .close;
    }

    say "Wrote $target";
}

sub ccc($code) {
    uniprop($code, 'Canonical_Combining_Class')
}

sub hexy($codes) {
    $codes.split(' ').map('0x' ~ *).join(', ')
}
