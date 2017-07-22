constant MAX_TESTS_PER_FILE    = 2000;
constant NUM_SANITY_TESTS      = 500;
constant SANITY_IDENTITY_RATIO = 3;
my $uni-version;
my Str:D $NFC-concat-tests = '';
my Int:D $NFC-concat-tests-number = 0;
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
    my $NFC-concat-target = 'S15-normalization/nfc-concat.t';
    $NFC-concat-target.IO.spurt(
        make-header($uni-version, $NFC-concat-tests-number)
        ~ "\n" ~ 'my @list; my @result;' ~ "\n"
        ~ $NFC-concat-tests
    ) and say "Wrote $NFC-concat-target";
}

sub write-test-files($template, $method, @source, @expected) {
    for ^ceiling(@source / MAX_TESTS_PER_FILE) -> $n {
        my @file-source = @source[lazy $n * MAX_TESTS_PER_FILE ..^ ($n + 1) * MAX_TESTS_PER_FILE];
        my @file-expected = @expected[lazy $n * MAX_TESTS_PER_FILE ..^ ($n + 1) * MAX_TESTS_PER_FILE];
        write-test-file($template ~ "-$n.t", $method, @file-source, @file-expected);
    }
    write-sanity-test-file($template ~ "-sanity.t", $method, @source, @expected);
}
sub make-header (Str:D $uni-version, Int:D $plan) {
    qq:to/HEADER/;
    use v6;
    # Unicode normalization tests, generated from NormalizationTests.txt in the
    # Unicode database by S15-normalization/test-gen.p6.
    # Generated from Unicode version $uni-version.

    use Test;

    plan $plan;
    HEADER
}

sub write-test-file($target, $method, @source, @expected) {
    my @last-list;
    my @last-result;
    given open($target, :w) {
        my $header = make-header($uni-version, @source.elems);
        .say: $header;
        for flat @source Z @expected -> $s, $e {
            .say: "ok Uni.new(&hexy($s)).$method.list ~~ (&hexy($e),), '$s -> $e';";
            if $method eq 'NFC' {
                my @list = hexy-unjoined($s);
                my @result = &hexy-unjoined($e);
                my $list-joined;
                my $result-joined;
                my $is-synthetic = False;
                # Only if there's at least two codepoints add it to the concat
                # test file
                if 1 < @list.elems {
                    $list-joined   = @list.join(', ');
                    $result-joined = @result.join(', ');
                    $NFC-concat-tests-number++;
                    $NFC-concat-tests ~= "\@list = $list-joined; \@result = $result-joined; \n";
                    $NFC-concat-tests ~= (
                        "ok all(((Uni.new(\@list[0..(\$_ - 1)]) ~ Uni.new(\@list[\$_..*]"
                       ~ ")).$method.list ~~ \@result for 1..(\@list-1))), "
                       ~ "'$list-joined -> $result-joined CONCAT';\n"
                    );
                }
            }
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
    hexy-unjoined($codes).join(', ')
}
sub hexy-unjoined($codes) {
    $codes.split(' ').map('0x' ~ *);
}
