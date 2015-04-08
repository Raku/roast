constant MAX_TESTS_PER_FILE = 2000;

sub MAIN(Str $unidata-normalization-tests) {
    # Parse the normalization test data.
    my @targets = my ($source, $nfc, $nfd, $nfkc, $nfkd) = [] xx 5;
    for $unidata-normalization-tests.IO.lines {
        next if /^['#'|'@'|\s+$]/;
        my @pieces = .split(';')[^5];
        .push(@pieces.shift) for @targets;
    }
    say "Parsed $source.elems() test cases.";

    # Write test files.
    write-test-files('t/spec/S15-normalization/nfc', 'NFC', $source, $nfc);
    write-test-files('t/spec/S15-normalization/nfd', 'NFD', $source, $nfd);
    #write-test-files('t/spec/S15-normalization/nfkc', 'NFKC', $source, $nfkc);
    write-test-files('t/spec/S15-normalization/nfkd', 'NFKD', $source, $nfkd);
}

sub write-test-files($template, $method, @source, @expected) {
    for ^ceiling(@source / MAX_TESTS_PER_FILE) -> $n {
        my @file-source = @source[$n * MAX_TESTS_PER_FILE ..^ ($n + 1) * MAX_TESTS_PER_FILE];
        my @file-expected = @expected[$n * MAX_TESTS_PER_FILE ..^ ($n + 1) * MAX_TESTS_PER_FILE];
        write-test-file($template ~ "-$n.t", $method, @file-source, @file-expected);
    }
}

sub write-test-file($target, $method, @source, @expected) {
    given open($target, :w) {
        .say: qq:to/HEADER/;
# Unicode normalization tests, generated from NormalizationTests.txt in the
# Unicode database by S15-normalization/test-gen.p6.

use Test;

plan @source.elems();
HEADER

        for @source Z @expected -> $s, $e {
            .say: "ok Uni.new(&hexy($s)).$method.list ~~ (&hexy($e),), '$s -> $e';";
        }

        .close;
    }

    say "Wrote $target";
}

sub hexy($codes) {
    $codes.split(' ').map('0x' ~ *).join(', ')
}
