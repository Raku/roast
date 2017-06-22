#!/usr/bin/env perl6
constant NFC_ROUNDTRIP_TEST_CASES = 500;
constant OTHER_ROUNDTRIP_TEST_CASES = 100;
my @source;
sub MAIN(Str $unidata-normalization-tests) {

    my $line-no = 0;
    for $unidata-normalization-tests.IO.lines {
        $line-no++;
        last if /^ \s* '@Part2'/; # We don't implement Part 2 yet
        next if /^['#'|'@'|\s+$]/;
        my @pieces = .split(';')[^5];
        my @columns = 'source', 'NFC', 'NFD', 'NFKC', 'NFKD';
        my %hash;
        for @columns -> $column {
            %hash{$line-no}{$column} = @pieces.shift.split(' ').map({:16($_)});
        }
        push @source, %hash;
    }
    say "Found @source.elems() tests for NFG tests.";
    # Write tests.
    write-roundtrip-test-file('S15-nfg/mass-roundtrip-nfc.t', @source, 'NFC', NFC_ROUNDTRIP_TEST_CASES);
    write-roundtrip-test-file('S15-nfg/mass-roundtrip-nfd.t', @source, 'NFD', OTHER_ROUNDTRIP_TEST_CASES, :CCC-only);
    write-roundtrip-test-file('S15-nfg/mass-roundtrip-nfkc.t', @source, 'NFKC', OTHER_ROUNDTRIP_TEST_CASES, :CCC-only);
    write-roundtrip-test-file('S15-nfg/mass-roundtrip-nfkd.t', @source, 'NFKD', OTHER_ROUNDTRIP_TEST_CASES, :CCC-only);
}

sub write-roundtrip-test-file($target, @source, $expected, $limit = Inf, Bool :$CCC-only = False) {
    my $file-string;
    my $fh = open($target, :w);
    my $count = 0;
    for @source -> %hash {
        for %hash.keys -> $key {
            next if %hash{$key}<source> eq %hash{$key}{$expected};
            if $CCC-only {
                # Parse the normalization test data, and gather those cases where the NFC
                # form contains a non-starter (Canonical_Combining_Class > 0).
                my $ccc = 0;
                for %hash{$key}<NFC>.cache {
                    if ccc($_) > 0 {
                        $ccc++;
                    }
                }
                next if $ccc <= 0;
            }
            my $source-str = &hexy(%hash{$key}<source>);
            my $expected-str = &hexy(%hash{$key}{$expected});
            $file-string ~= "ok Uni.new($source-str).Str.$expected.list ~~ ($expected-str,), '$source-str -> Str -> $expected-str NormalizationTest.txt line no $key';\n";
            $count++;
            last if $count >= $limit;
        }
        last if $count >= $limit;
    }
    say "Found $count interesting cases for $expected NFG tests.";
    my $header = qq:to/HEADER/;
    use v6;
    # Normal Form Grapheme roundtrip tests, generated from NormalizationTests.txt in
    # the Unicode database by S15-nfg/test-gen.p6. Check we can take a Uni, turn it
    # into an NFG string, and then get codepoints back out of it in $expected.

    use Test;

    plan $count;
    HEADER
    $fh.say( $header ~ $file-string);
    $fh.close;
    say "Wrote $target";
}

sub ccc($code) {
    uniprop($code, 'Canonical_Combining_Class')
}

sub hexy(@list) {
    @list.».base(16).map('0x' ~ *).join(', ');
}
