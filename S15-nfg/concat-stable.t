use Test;
# The script examples in the .txt of this project are taken from wikipedia.org and
# are licensed under the CC 3.0 Share Alike license
# https://creativecommons.org/licenses/by-sa/3.0/
# See Retreived.txt for dates and URL's they were retreived from
my $num-regional-indicator-tests = 34;
sub MAIN (:$scripts = <Hangul Arabic Tibetan>, Int:D :$repeat = 1, Bool:D :$no-test-concat = False) {
    my IO::Path $path = $?FILE.IO.parent(2).add("3rdparty/wikipedia");
    die("Could not 3rdparty/wikipedia") unless $path.e && $path.d;
    plan 7 * $scripts.elems + $num-regional-indicator-tests;
    for $scripts.words -> $script {
        my $text = $path.child("$script.txt").slurp;
        test-script($text, :test-concat(!$no-test-concat) )
            for ^$repeat;
    }
    test-regional();
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
sub test-regional-indicators(
  $text, @chars-to-test, @graphs, @cps
) is test-assertion {
    is-deeply @chars-to-test, @graphs, "Regional Indicators: Graphemes compare correct in initial test of $text";
    for ^@graphs -> $i {
        is-deeply @graphs[$i].ords, @cps[$i], "Regional Indicators:  Codepoints in isolated grapheme $i are correct";
    }
    for ^@chars-to-test -> $i {
        is-deeply @chars-to-test[$i].ords, @cps[$i], "Regional Indicators:  Codepoints in grapheme $i created from $text is correct";
        is-deeply @chars-to-test[$i].chars, 1, "Regional Indicators:  Number of graphemes in grapheme $i created from $text is correct";
    }

}
sub test-regional() is test-assertion {
    {
        my $text = "join+comb";
        my @chars-to-test = ("a", "🇦", "🇧", "🇨", "🇩", "b").join.comb;
        my @graphs = "a", "🇦🇧", "🇨🇩", "b";
        my @cps    = (("a",), ("🇦", "🇧"), ("🇨","🇩"), ("b",)).deepmap(*.ord);
        test-regional-indicators(
            $text,
            @chars-to-test,
            @graphs,
            @cps
        );
    }
    {
        my $text = "concat+comb 1";
        my Str:D $concat = "🇦🇧" ~ "🇨🇩";
        my @chars-to-test = $concat.comb;
        my @graphs =  "🇦🇧", "🇨🇩";
        my @cps = ( ("🇦","🇧"), ("🇨", "🇩") ).deepmap(*.ord);
        test-regional-indicators(
            $text,
            @chars-to-test,
            @graphs,
            @cps
        );
    }
    {
        my $text = "concat+comb 2";
        my Str:D $concat = "🇦🇧" ~ "🇨";
        my @chars-to-test = $concat.comb;
        my @graphs =  "🇦🇧", "🇨";
        my @cps = ( ("🇦","🇧"), ("🇨",) ).deepmap(*.ord);
        test-regional-indicators(
            $text,
            @chars-to-test,
            @graphs,
            @cps
        );
    }
    {
        my $text = "concat+comb 3";
        my Str:D $concat = "🇦🇧🇨" ~ "🇩";
        my @chars-to-test = $concat.comb;
        my @graphs =  "🇦🇧", "🇨🇩";
        my @cps = ( ("🇦","🇧"), ("🇨","🇩") ).deepmap(*.ord);
        test-regional-indicators(
            $text,
            @chars-to-test,
            @graphs,
            @cps
        );
    }

}

# vim: expandtab shiftwidth=4
