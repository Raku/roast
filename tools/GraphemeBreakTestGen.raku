#!/usr/bin/env raku

# XXX test without subtest {}, without {} at all, to see if either can make a
# faster-booting test file.

# at present, the GraphemeBreakTest.txt file is written with no blank lines, so
# this grammar is written accordingly.
grammar GBT {
    token TOP {
        <version>
        <.comment>*
        <test-line>+
        <.comment>*
    }

    token version {
        ^^ '# GraphemeBreakTest-' <([<.digit>+] +% '.')> '.txt' \n
    }

    rule test-line {
        <.ws>

        # it only makes sense for these test lines to start and end with break
        # opportunities. If they don't, that's a sign that the format's changed.
        [ '÷' || <![#]> { die "Test line doesn't start with ÷. Has the format changed?" } ]

        <grapheme> +% '÷'

        [ '÷' || { die "Test line doesn't end with ÷. Has the format changed?" } ]

        [
        | <.comment>?
        | [\n || $]
        ]
    }

    token grapheme { <hexval> +% [<.ws> '×' <.ws>] }

    token hexval { <.xdigit>+ }

    token comment { <.ws> '#' \N* [\n || $] }

    token ws { <!ww> \h* }
}

class OneTest {
    has Uni $.whole-string;
    has Uni @.expected-graphemes;

    # The number of tests added to the main body of the .t file. For example, if
    # this class wraps every test it makes in a subtest(), the answer is 1.
    method test-count() { 1 }

    method test-code() {
        # currently, we test each grapheme and also test for the number of
        # graphemes found (the total count test is required to flag cases where
        # the compiler under test generates more graphemes than expected, but
        # the first N graphemes all happen to match the N graphemes we're
        # expecting).
        my $subcount = +@.expected-graphemes + 1;

        # We want the test file to contain a string where you can see the
        # original sequence of codepoints exactly as specified, doesn't
        # potentially frustrate readers with invisible or otherwise funky
        # codepoints being in the source code literally, and gets turned into a
        # list of graphemes with minimal fuss. The solution is a string in the
        # form "\x[code,code,...]".
        #
        # By the way, for those worried: grapheme cluster boundaries are defined
        # to be consistent across normalization forms (and unnormalized text),
        # so as long as we NFC-normalize the individual graphemes too, the fact
        # that Raku's grapheme-forming always NFCs the text isn't an issue.
        my $x-string = Q:c｢"\x[{$.whole-string.list».fmt("%04X").join(",")}]"｣;

        my $res = qq:to/EOPRE/;
subtest "Codepoint sequence $x-string.raku.chop.substr(1)", \{
    plan $subcount;

    my @chars = {$x-string}.comb;

    is +@chars, {+@.expected-graphemes}, "Correct number of graphemes";
EOPRE

        # now to generate the test lines for each individual grapheme. DO NOT
        # USE is() HERE, it uses infix:<eq> which currently coerces to Str. We
        # don't want to invoke NFG strings in this test file outside of the
        # actual grapheme formation test. If everything's working fine it
        # wouldn't harm anything, but the point of tests is to consider cases
        # where things aren't fine.
        for @.expected-graphemes.kv -> $k, $v {
            # using an empty string (in case of too few graphemes generated) as
            # fallback is fine, graphemes can't be zero-width. We have the test
            # generate the NFC'd individual graphemes at run time so that people
            # reading the source text can easily see where in $x-string the
            # boundaries are meant to be.
            $res ~= Q:s:c｢    is-deeply (@chars[$k]//"").NFC, {$v.raku}.NFC, "Grapheme {$k+1}/{+@.expected-graphemes}";｣;
            $res ~= "\n";
        }

        # close off the test string and return it
        $res ~= "}\n";
        $res;
    }
}

class TestData {
    has Str $.universion;
    has OneTest @.lines;

    # Writes (a portion) of the test data to the indicated file. Simplifies
    # splitting the data up across multiple test files. The first invocation
    # should set $start to zero. The return value is the next start value, or
    # the size of @.lines if we've gone through them all.
    method write-file(IO(Str) $path, UInt $start, UInt $count) {
        die "Cannot write from position $start in a {+@.lines}-element array" if $start >= +@.lines;

        my $last = ($start + $count) min +@.lines;
        my @subset = @.lines[$start..^$last];

        my $test-count = [+] @subset».test-count;
        my $test-code = @subset».test-code.join("\n");

        my $filetext = qq:to/EOT/;
# Generated from GraphemeBreakTest.txt, Unicode version $.universion
# Test lines $start..^$last
use Test;
plan $test-count;

$test-code
EOT

        my $outfile = open($path, :w);
        $outfile.print($filetext);
        $outfile.close();

        $last;
    }
}

class GBTActions {
    method TOP($/) {
        make TestData.new(:universion($<version>.ast)
                          :lines($<test-line>».ast));
    }

    method version($/) { make ~$/.Str }

    method test-line($/) {
        my @expected-graphemes = $<grapheme>».ast;
        my $whole-string = Uni.new(@expected-graphemes».list);

        make OneTest.new(:$whole-string,
                         :@expected-graphemes);
    }

    method grapheme($/) {
        # don't allow any normalization until we really want it
        make Uni.new($<hexval>».ast);
    }

    method hexval($/) { make $/.Str.parse-base(16) }
}

sub MAIN(IO(Str) $gbt-file #=(Pathname for the GraphemeBreakTest.txt file, from UNIDATA.)) {
    my $roast-root = qx{git rev-parse --show-toplevel}.trim.IO;

    my $out-dir = $roast-root.child("S15-nfg");

    unless $out-dir ~~ :e & :d {
        note "Directory $out-dir.Str.raku() not found. Did you run this from within the roast repo?";
        exit 1;
    }

    unless GBT.parsefile($gbt-file, :actions(GBTActions)) {
        note "Couldn't parse file $gbt-file.Str.raku(). Either this isn't the GraphemeBreakTest.txt file we want, or its format has changed.";
        exit 1;
    }

    my $tdata = $/.ast;

    my $from = 0;
    my $file-idx = 0;

    while ($from < $tdata.lines.elems) {
        my $path = $out-dir.child("GraphemeBreakTest-{$file-idx}.t");

        $from = $tdata.write-file($path, $from, 200);
        $file-idx++;
    }

    say "Don't forget to update docs/unicode-generated-tests.asciidoc to indicate that you've updated this and other test files!";
}