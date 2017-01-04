constant MAX_TESTS_PER_FILE    = 2000;
constant NUM_SANITY_TESTS      = 500;
constant SANITY_IDENTITY_RATIO = 3;
my $uni-version;
sub MAIN(Str $unidata-normalization-tests) {
    # Parse the normalization test data.
    my @targets = my ($source, $nfc, $nfd, $nfkc, $nfkd) = [] xx 5;
    for $unidata-normalization-tests.IO.lines {
        if /^'#'\s* 'NormalizationTest-' $<ver>=(\S*) '.txt'/ {
            $uni-version = ~$<ver>;
        }
        next if /^['#'|'@'|\s+$]/;
        my @pieces = .split(';')[^5];
        .push(@pieces.shift) for @targets;
    }
    say "Parsed $source.elems() test cases.";

    # Write test files.
    write-test-files('S15-normalization/nfc', 'NFC', $source, $nfc);
    write-test-files('S15-normalization/nfd', 'NFD', $source, $nfd);
    write-test-files('S15-normalization/nfkc', 'NFKC', $source, $nfkc);
    write-test-files('S15-normalization/nfkd', 'NFKD', $source, $nfkd);
}

sub write-test-files($template, $method, @source, @expected) {
    for ^ceiling(@source / MAX_TESTS_PER_FILE) -> $n {
        my @file-source = @source[lazy $n * MAX_TESTS_PER_FILE ..^ ($n + 1) * MAX_TESTS_PER_FILE];
        my @file-expected = @expected[lazy $n * MAX_TESTS_PER_FILE ..^ ($n + 1) * MAX_TESTS_PER_FILE];
        write-test-file($template ~ "-$n.t", $method, @file-source, @file-expected);
    }
    write-sanity-test-file($template ~ "-sanity.t", $method, @source, @expected);
}

sub write-test-file($target, $method, @source, @expected) {
    given open($target, :w) {
        .say: qq:to/HEADER/;
use v6;
# Unicode normalization tests, generated from NormalizationTests.txt in the
# Unicode database by S15-normalization/test-gen.p6.
# Generated from Unicode version $uni-version.

use Test;

plan @source.elems();
HEADER

        for flat @source Z @expected -> $s, $e {
            .say: "ok Uni.new(&hexy($s)).$method.list ~~ (&hexy($e),), '$s -> $e';";
        }

        .close;
    }

    say "Wrote $target";
}

sub write-sanity-test-file($target, $method, @source, @expected) {
    my $generated                  = 0;
    my $generated-since-last-ident = 0;

    given open($target, :w) {
        .say: qq:to/HEADER/;
use v6;
# Unicode normalization tests, generated from NormalizationTests.txt in the
# Unicode database by S15-normalization/test-gen.p6.
# Generated from Unicode version $uni-version.

use Test;

plan {NUM_SANITY_TESTS};
HEADER

        for flat @source Z @expected -> $s, $e {
            if $s eq $e {
                next if $generated-since-last-ident < SANITY_IDENTITY_RATIO;
                $generated-since-last-ident -= SANITY_IDENTITY_RATIO;
            }
            else {
                $generated-since-last-ident++;
            }
            .say: "ok Uni.new(&hexy($s)).$method.list ~~ (&hexy($e),), '$s -> $e';";
            last if ++$generated == NUM_SANITY_TESTS;
        }

        .close;
    }

    say "Wrote $target";
}

sub hexy($codes) {
    $codes.split(' ').map('0x' ~ *).join(', ')
}
