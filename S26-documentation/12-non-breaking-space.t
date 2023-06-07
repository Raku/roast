use Test;

use lib $?FILE.IO.parent(2).add('packages/Test-Helpers');
use Test::Misc :int2hexstr, :show-space-chars;

# Vars defined in the BEGIN block at the end of this file:
my (@nbchars, @bchars);
my $nbchar-count = @nbchars.elems;

plan 2; # two subtests

subtest "Test fix for issue GH 1852" => {
    # fix for GH #1852: pod handling converts non-breaking space to normal space
    #
    # from the issue description:
    #
    #   =head1 Talking about Perl 6
    #   say "Talking about Perl 6".comb.map: *.ord;
    #   say $=pod[0].contents[0].contents[0].comb.map: *.ord;
    #

    # Note the unicode hex number for some horizontal whitespace chars are
    # (from docs, regexes):
    #
    #   U+0020 SPACE
    #   U+00A0 NO-BREAK SPACE
    #   U+0009 CHARACTER TABULATION
    #   U+2001 EM QUAD
    #
    # To enter a unicode hex number using emacs: C-x 8 RET hex RET
    =head1 Raku Language

    my $p = $=pod[0];
    my @raw-chars = "Raku Language".comb;
    my @pod-chars = $p.contents[0].contents[0].comb;
    my $raw-char = @raw-chars[4];
    my $pod-char = @pod-chars[4];

    plan 3;

    # the three planned tests
    is $raw-char.ord.base(16), 'A0', 'non-breaking space as entered by the user';
    is $pod-char.ord.base(16), 'A0', "user's non-breaking whitespace is unchanged by pod processing";
    is $raw-char.ord.base(16), $pod-char.ord.base(16), "user's non-breaking white space is unchanged by pod processing";
}

subtest "Test non-breaking spaces in tables..." => {

    plan $nbchar-count + 1;

    my $pod = gen-pod;
    is $pod.contents.elems, $nbchar-count, "table contains elems for all known non-breaking spaces";
    for 0..^$nbchar-count -> $i {
        my $nbspc = @nbchars[$i].chr;
        my $row = $i + 1;
        subtest "Row $row, char 0x" ~ @nbchars[$i].base(16) => {
            plan 4;
            my $res0 = "Raku{$nbspc}Language is the best!";
            my $res1 = "Raku {$nbspc} Language is the best!";
            my $c0 = show-space-chars($pod.contents[$i][0]);
            my $r0 = show-space-chars($res0);
            my $c1 = show-space-chars($pod.contents[$i][1]);
            my $r1 = show-space-chars($res1);
            is $pod.contents[$i][0], $res0, "col 1: content matches";
            is $c0, $r0, "col 1: all spaces match";
            is $pod.contents[$i][1], $res1, "col 2: content matches";
            is $c1, $r1, "col 2: all spaces match";
        }
    }
}

##### subroutines #####
sub gen-pod {
    my $code = "";
    my $pod;
    $code ~= q:to/HERE/;
        # two-column table with various whitespace chars
        =begin table
        HERE

    # make one testing row per non-breaking space char
    for @nbchars -> $nbc {
        # first column
        $code ~= "Raku";
        $code ~= $nbc.chr;
        $code ~= "Language";
        for @bchars -> $c {
            $code ~= $c.chr;
        }
        $code ~= "is the best!";

        # second column
        $code ~= ' | ';
        $code ~= "Raku ";
        $code ~= $nbc.chr;
        $code ~= " Language";
        for @bchars -> $c {
            $code ~= $c.chr;
        }
        $code ~= "is the best!\n";
    }
    $code ~= "=end table\n";
    $code ~= "\$pod = \$=pod[0]";
    EVAL $code;
    $pod
}

BEGIN {
    # non-breaking ws chars
    @nbchars = [
        0x00A0, # NO-BREAK SPACE
        0x202F, # NARROW NO-BREAK SPACE
        0x2060, # WORD JOINER
        0xFEFF, # ZERO WIDTH NO-BREAK SPACE
    ];
    # breaking ws chars
    @bchars = [
        # don't use the vertical chars for this test which is single-line oriented
        #0x000A, # LINE FEED (LF)              vertical
        #0x000B, # LINE TABULATION             vertical
        #0x000C, # FORM FEED (FF)              vertical
        #0x000D, # CARRIAGE RETURN (CR)        vertical
        #0x2028, # LINE SEPARATOR              vertical
        #0x2029, # PARAGRAPH SEPARATOR         vertical

        0x0009, # CHARACTER TABULATION
        0x0020, # SPACE
        0x1680, # OGHAM SPACE MARK
        0x180E, # MONGOLIAN VOWEL SEPARATOR
        0x2000, # EN QUAD <= normalized to 0x2002
        0x2001, # EM QUAD <= normalized to 0x2003
        0x2002, # EN SPACE
        0x2003, # EM SPACE
        0x2004, # THREE-PER-EM SPACE
        0x2005, # FOUR-PER-EM SPACE
        0x2006, # SIX-PER-EM SPACE
        0x2007, # FIGURE SPACE                <= unicode considers this non-breaking, but we won't
        0x2008, # PUNCTUATION SPACE
        0x2009, # THIN SPACE
        0x200A, # HAIR SPACE                  <= PROBLEM
        0x205F, # MEDIUM MATHEMATICAL SPACE
        0x3000, # IDEOGRAPHIC SPACE
    ];
}
# vim: expandtab shiftwidth=4
