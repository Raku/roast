#!/usr/bin/env perl6
# Generates tests from GraphemeBreakPropertyTest.txt from UNIDATA
# At the moment this test only checks how many graphemes we think exist
# in the string. The test itself defines points where we should break or
# not break. For now we just test if the number of graphemes is correct.
# This is mostly good enough.
use v6;
sub MAIN ( Str $EmojiTest-file ) {
    my @text = $EmojiTest-file.IO.slurp.lines;
    my $line-no = 0;
    my $emoji-version;
    my @array;
    my $test-count;
    for @text -> $line {
        $line-no++;
        if $line ~~ / ^ \s* '#' \s* 'Version:'\s*$<uni-ver>=(\S+)/ {
            $emoji-version = ~$<uni-ver>;
        }
        next if $line ~~ / ^ \s* '#' /;
        next if $line ~~ / ^ \s* $ /;
        $line ~~ / ^ $<beginning>=(.*) '#' $<comment>=( .* ) $ /;
        if ! defined any($<comment>, $<beginning>) {
            say "Something went wrong.";
            say "Or maybe you need to update this script?";
            exit 1
        }
        my $comment = $<comment>.trim;
        my $beginning = $<beginning>.trim;

        my $term = $beginning.split(';')[0];
        my $string;
        my $uni-codes;
        my $fail = False;
        my $ord-count = 0;
        for $term.split(' ') -> $thing is copy {
            next if $thing eq '';
            my $number = $thing.parse-base(16);
            $string ~= $thing.parse-base(16).chr;
            $uni-codes ~= "0x$thing.parse-base(16).base(16), ";
            $ord-count++;
            CATCH {$fail = True; last; }
        }
        next if $fail == True;
        $uni-codes ~~ s/ ', ' $ //;
        if $ord-count > 1 {
            push @array, "## $line # emoji-test.txt line #$line-no Emoji version $emoji-version";
            push @array, qq<is Uni.new($uni-codes).Str.chars, 1, "Codes: ⟅$uni-codes⟆ $comment";>;
            $test-count++;
        }
    }
    my $file =
    qq:to/END/;
    # Test generated from GraphemeBreakTest.txt Emoji version $emoji-version
    use v6;
    use Test;
    plan $test-count;
    END
    for @array {
        $file ~= $_ ~ "\n";
    }
    spurt "S15-nfg/emoji-test.t", $file;
}
