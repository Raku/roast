#!/usr/bin/env perl6
use Test;
# The script examples in the .txt of this project are taken from wikipedia.org and
# are licensed under the CC 3.0 Share Alike license
# https://creativecommons.org/licenses/by-sa/3.0/
# See Retreived.txt for dates and URL's they were retreived from
sub MAIN (:$scripts = <Hangul Arabic Tibetan>, Int:D :$repeat = 1, Bool:D :$no-test-concat = False) {
    my IO::Path $path = "t/spec/3rdparty/wikipedia".IO.d
                ?? "t/spec/3rdparty/wikipedia".IO
            !! "3rdparty/wikipedia".IO.d
                ?? "3rdparty/wikipedia".IO
                !! die("Could not find t/spec/3rdparty/wikipedia or 3rdparty/wikipedia");
    plan 7 * $scripts.elems;
    for $scripts.words -> $script {
        my $text = $path.child("$script.txt").slurp;
        test-script($text, :test-concat(!$no-test-concat) )
            for ^$repeat;
    }
    sub test-script (Str $string is copy, Bool:D :$test-concat = True) {
        my $script = $string.uniprop('Script');
        # Just in case somebody's git is set to alter line endings on checked out files
        # Make sure both strings have the correct lineendings before proceeding
        my $crnl-string = S:g/ \n | \r\n /\r\n/ given $string;
        my $nl-string   = S:g/ \r\n | \n /\n/ given $string;
        my @ords = $crnl-string.ords;

        is-deeply $crnl-string.chars, $nl-string.chars, "\\r\\n newline has same number of .chars as \\n in $script";
        my $crnl-string-NFD = $crnl-string.NFD;
        my $nl-string-NFD = $nl-string.NFD;
        is-deeply $crnl-string-NFD.NFC.Str, $crnl-string, "$script text \\r\\n newlines roundtrips NFD to NFC";
        is-deeply $nl-string-NFD.NFC.Str, $nl-string, "$script text \\n newlines roundtrips NFD to NFC";
        my $eq-ok = 0;
        my $chars-ok = 0;
        sub test-concat (@ords) {
            for 1..@ords.elems {
              my @o = @ords;
              my @n = @o.shift xx $_;
              my $concatted = @n.chrs ~ @o.chrs;
              $eq-ok++ if $concatted eq $crnl-string;
              $chars-ok++ if $concatted.chars == $crnl-string.chars;
            }
            is-deeply $eq-ok, (1..@ords.elems).elems, "$script concat equal";
            is-deeply $chars-ok, (1..@ords.elems).elems, "$script concat charcount equal";
        }
        if $test-concat {
            test-concat(@ords);
            my @ords-swapped = @ords.pick(@ords.elems);
            die if @ords eqv @ords-swapped;
            test-concat(@ords-swapped);
        }


    }
}
