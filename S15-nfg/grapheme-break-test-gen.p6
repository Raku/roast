sub MAIN(Str $grapheme-break-test-file) {
    my constant TEST_FILE = 't/spec/S15-nfg/grapheme-break.t';

    my class TestCase {
        has @.codes;
        has @.grapheme-codes;
        has $.description;
    }

    my @cases = $grapheme-break-test-file.IO.lines.map: {
        next if /^\s*'#'/;
        my ($spec, $description) = .split(/'#' \s+/);
        my $case = TestCase.new(:$description);
        for $spec.split(/\s* '÷' \s*/).grep(* ne '') -> $graph {
            my @codes = $graph.split(/\s* '×' \s*/);
            $case.codes.append(@codes);
            $case.grapheme-codes.push(@codes);
        }
        $case
    }
    say "Found @cases.elems() test cases.";

    given open(TEST_FILE, :w) {
        .say: qq:to/HEADER/;
use v6.c;
# Tests generated from the Unicode Character Database's GraphemeBreakTest.txt
# by S15-nfg/grapheme-break-test-gen.p6.

use Test;

plan @cases.elems();
HEADER

        for @cases -> $c {
            .say: qq:to/TEST/;
                is Uni.new(&hexy($c.codes)).Str.chars, $c.grapheme-codes.elems(), '$c.description()';
                TEST
        }

        .close;
    }
    say "Wrote tests to {TEST_FILE}";
}

sub hexy($codes) {
    $codes.split(' ').map('0x' ~ *).join(', ')
}
