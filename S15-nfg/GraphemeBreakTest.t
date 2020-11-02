## WHEN UPDATING UNICODE VERSION ALSO UPDATE docs/unicode-generated-tests.asciidoc
use v6;
my IO::Path $repo-dir      = $?FILE.IO.parent(2).add("3rdparty/Unicode/13.0.0/ucd/auxiliary/GraphemeBreakTest.txt");
my IO::Path $rakudo-subdir = $?FILE.IO.parent(2);
my IO::Path $rakudo-dir    = $rakudo-subdir.child($repo-dir);
my Str:D    $location      = $rakudo-dir.e ?? $rakudo-dir.Str !! $repo-dir.Str;
our $DEBUG;
use Test;
=begin pod
=NAME Unicode GraphemeBreakTest

=DESCRIPTION
Unicode Data files in 3rdparty/Unicode/ and the snippet of commented code below
are under SPDX-License-Identifier: Unicode-DFS-2016
See 3rdparty/Unicode/LICENSE for full text of license.
From GraphemeBreakTest.txt Unicode 9.0

=USAGE
If you run the script with --only=900,888 it will run only the line numbers
supplied as a commas seperated list of line numbers. Using --debug will give
additional debug info. Can supply datafile manually with --file=filename.txt
but that should not be required.

    # Default Grapheme Break Test
    #
    # Format:
    # <string> (# <comment>)?
    #  <string> contains hex Unicode code points, with
    #	÷ wherever there is a break opportunity, and
    #	× wherever there is not.
    #  <comment> the format can change, but currently it shows:
    #	- the sample character name
    #	- (x) the Grapheme_Cluster_Break property value for the sample character
    #	- [x] the rule that determines whether there is a break or not

=head1 HOW TO FUDGE
=para The keys of the hash below are full text lines of the unicode test document.
This is so if the line numbers change with a new unicode version, the tests stay fudged
Values are either set to ALL or set to one or more of C,0,1,2,3,4..

ALL is for all checks (C, 0, 1 ...)
C is the check for number of codepoints
0 is the check for what codepoints end up in grapheme 0
1 is the check for what codepoints end up in grapheme 1
and so on for further graphemes

=para B<Example>:

=item3 C<not ok 2384 - Line 835: grapheme [1] has correct codepoints>

=para You can add 835 => ['1'] to the hash and it will fudge that line for you

=end pod
# Watch out, these lines have tabs in them, and won't match if you don't include the tabs in the fudge!
my %fudged-test-lines =
"÷ 0061 × 200D ÷ 1F6D1 ÷\t#  ÷ [0.2] LATIN SMALL LETTER A (Other) × [9.0] ZERO WIDTH JOINER (ZWJ_ExtCccZwj) ÷ [999.0] OCTAGONAL SIGN (ExtPict) ÷ [0.3]" => ['ALL'],
"÷ 2701 × 200D × 2701 ÷\t#  ÷ [0.2] UPPER BLADE SCISSORS (Other) × [9.0] ZERO WIDTH JOINER (ZWJ_ExtCccZwj) × [11.0] UPPER BLADE SCISSORS (Other) ÷ [0.3]" => ['ALL'],
"÷ 200D ÷ 231A ÷\t#  ÷ [0.2] ZERO WIDTH JOINER (ZWJ_ExtCccZwj) ÷ [999.0] WATCH (ExtPict) ÷ [0.3]" => ['ALL']
;
# %ok-normalization is a list of input codepoints to output codepoints
# This is an extra failsafe, because if unexpected normalization happens the test
# results could be unexpected. New things should be checked MANUALLY against the UCD
# Decomposition_Mapping property values defined in UnicodeData.txt
constant %ok-normalization =
    "44032,4520" => "44033",
    "97,776"     => "228",
;
constant @lines-with-normalization = (
    #419 => [ 0, ],
    #604 => [ 0, ],
    #608 => [ 0, ],
    #616 => [ 0, ],
    #624 => [ 0, ], #fails hard, commmented out in GraphemeBreakTest.txt
    #625 => [ 0, ], #fails hard, commmented out in GraphemeBreakTest.txt
    #626 => [ 0, ],
);
sub MAIN (Str:D :$file = $location, Str :$only, Bool:D :$debug = False) {
    $DEBUG = $debug;
    note "WHEN UPDATING UNICODE VERSION ALSO UPDATE docs/unicode-generated-tests.asciidoc";
    my @only = $only ?? $only.split([',', ' ']) !! Empty;
    die "Can't find file at ", $file.IO.absolute unless $file.IO.f;
    note "Reading file ", $file.IO.absolute;
    my @fail;
    if (!$only) {
        plan (1716); #1943
    }
    for $file.IO.lines -> $line {
        process-line $line, @fail, :@only;
    }
    my $bag = @fail.Bag;
    note "Grapheme_Cluster_Break test: Failed {$bag.elems} lines: ", $bag;
}

grammar GraphemeBreakTest {
    token TOP { [<.ws> [<break> | <nobreak>] <.ws>]+ % <hex> <comment> }
    token hex     { <:AHex>+ }
    token break   { '÷'      }
    token nobreak { '×'      }
    token comment { '#' .* $ }
}
class parser {
    has @!ord-array;
    method TOP ($/) {
        my @list =  $/.caps;
        my @stack;
        my @results;
        note $/ if $DEBUG;
        sub move-from-stack {
            if @stack {
                @results[@results.elems].append: @stack;
                @stack = [];
            }
        }
        for @list {
            if .key eq 'nobreak' {
                say 'nobreak' if $DEBUG;
            }
            elsif .key eq 'break' {
                note 'break' if $DEBUG;
                move-from-stack;
            }
            elsif .key eq 'hex' {
                @stack.push: :16(~.value);
            }
        }
        my $string =  @results».List.flat.chrs;
        move-from-stack;
        note @results.raku if $DEBUG;
        make {
            string    => $string,
            ord-array => @results
        }
    }
}
sub process-line (Str:D $line, @fail, :@only!) is test-assertion {
    state $line-no = 0;
    $line-no++;
    return if @only and $line-no ne @only.any;
    return if $line.starts-with('#');
    my Bool:D $fudge-b = %fudged-test-lines{$line}.Bool;
    note 'LINE: [' ~ $line ~ ']' if $DEBUG;
    my $list = GraphemeBreakTest.parse(
        $line,
        actions => parser
    ).made;
    die "line $line-no undefined parse" if $list.defined.not;
    if $fudge-b {
        if %fudged-test-lines{$line}.any eq 'ALL' {
            todo("line $line-no todo for {%fudged-test-lines{$line}.Str} tests", 1 + $list<ord-array>.elems);
            $fudge-b = False; # We already have todo'd don't attempt again
        }
        elsif %fudged-test-lines{$line}.any eq 'C' {
            todo("[C] num of chars line $line-no", 1);
        }
    }
    is-deeply $list<ord-array>.elems, $list<string>.chars, "Line $line-no: [C] right num of chars | {$list<string>.uninames.raku}" or @fail.push($line-no);
    for ^$list<ord-array>.elems -> $elem {
        if $fudge-b and %fudged-test-lines{$line}.any eq $elem {
            todo "[$elem] grapheme line $line-no todo";
        }
        # Here by expected we mean "as if there were no normalization"
        my Array $expected;
        {
            my $expected-if-no-normalization = $list<ord-array>[$elem].flat.Array;
            my Array $got-from-normalization = $expected-if-no-normalization.chrs.ords.Array;
            my $got-from-normalization-str = $got-from-normalization.join(',');
            my $expected-if-no-normalization-str = $expected-if-no-normalization.join(',');
            if %ok-normalization{$expected-if-no-normalization-str} && %ok-normalization{$expected-if-no-normalization-str} eq $got-from-normalization-str {
                $expected = $got-from-normalization;
            }
            elsif $got-from-normalization !eqv $expected-if-no-normalization {
                die "codepoints change under normalization. manually check and add an exception or fix the script\n" ~ "
                line no $line-no: elem $elem. Got: ", $got-from-normalization-str, ' from: ', $expected-if-no-normalization-str;
            }
            else {
                $expected = $expected-if-no-normalization;
            }
        }
        is-deeply $list<string>.substr($elem, 1).ords.flat.Array, $expected, "Line $line-no: grapheme [$elem] has correct codepoints" or @fail.push($line-no);
    }
}

# vim: expandtab shiftwidth=4
