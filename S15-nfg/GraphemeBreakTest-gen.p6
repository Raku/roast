#!/usr/bin/env perl6
# Generates tests from GraphemeBreakPropertyTest.txt from UNIDATA
# At the moment this test only checks how many graphemes we think exist
# in the string. The test itself defines points where we should break or
# not break. For now we just test if the number of graphemes is correct.
# This is mostly good enough.
use v6;
sub MAIN ( Str $GrahemeBreakTest-file ) {
    my @text = $GrahemeBreakTest-file.IO.slurp.lines;
    my $line-no = 0;
    my $unicode-version;
    my @array;
    my $test-count;
    for @text -> $line {
        $line-no++;
        if $line ~~ / ^ \s* '#' \s* 'GraphemeBreakTest-' $<uni-ver>=(\d+'.'\d+'.'\d+) '.txt'/ {
            $unicode-version = ~$<uni-ver>;
        }
        next if $line ~~ / ^ \s* '#' /;
        $line ~~ / ^ $<beginning>=(.*) '#' $<comment>=( .* ) $ /;
        if ! defined any($<comment>, $<beginning>) {
            say "Something went wrong.";
            say "Or maybe you need to update this script?";
            exit 1
        }
        my $comment = $<comment>.trim;
        my $beginning = $<beginning>.trim;
        # Remove the beginning and end, since we always break at start and end of string
        $beginning ~~ s/ ^ .*? ( <:AHex> .* <:AHex> ) .*? $ /$0/;
        my $term = $beginning;
        my $num_codes = $beginning.comb(/'×'|'÷'/).elems + 1;
        my $no-break = $beginning.comb(/'×'/).elems;
        # Remove all the 'break' symbols, we only care about where *not* to break
        $beginning ~~ s:g/'÷'|'×'//;
        # Count how many codepoints we are not supposed to break between
        $beginning ~~ s:g/' '+/ /;
        my $string;
        my $uni-codes;
        my $fail= False;
        for $beginning.split(' ') -> $thing is copy {
            next if $thing eq '';
            my $number = $thing.parse-base(16);
            # Private Use High Surrogate is probably not supposed to be used in UTF-8
            if $number eq '55296' {
                $fail = True;
                last;
            }
            $string ~= $thing.parse-base(16).chr;
            $uni-codes ~= "0x$thing.parse-base(16).base(16), ";
            CATCH {$fail = True; last; }
        }
        next if $fail == True;
        $uni-codes ~~ s/ ', ' $ //;
        my $should-be = $num_codes - $no-break;
        if $num_codes <= 0 {
            die "Line no $line-no got 0 for number of characters, something is wrong. No-break[$no-break] Codes[$num_codes]";
        }
        if ! $unicode-version {
            say "Warning, could not detect the Unicode version in the file. Please fix.";
            exit 1;
        }
        push @array, "## $comment # GraphemeBreakTest.txt line #$line-no Unicode Version $unicode-version";
        push @array, qq<is Uni.new($uni-codes).Str.chars, $should-be, "$comment | Codes: $num_codes Non-break: $no-break";>;
        $test-count++;
    }
    my $file =
    qq:to/END/;
    # Test generated from GraphemeBreakTest.txt Unicode version $unicode-version
    use v6;
    use Test;
    plan $test-count;
    END
    for @array {
        $file ~= $_ ~ "\n";
    }
    spurt "S15-nfg/GraphemeBreakTest.t", $file;
}
