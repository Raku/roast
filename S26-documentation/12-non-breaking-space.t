use v6;

use Test;

    # non-breaking ws chars
    my @nbchars = [
        0x00A0, # NO-BREAK SPACE
        0x202F, # NARROW NO-BREAK SPACE
        0x2060, # WORD JOINER
        0xFEFF, # ZERO WIDTH NO-BREAK SPACE
    ];
    # breaking ws chars
    my @bchars = [
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

##### some subroutines for the EVALed file #####
sub int2hexstr($int, :$plain) {
    # given an int, convert it to a hex string
    if !$plain {
        return sprintf("0x%04X", $int);
    }
    else {
        return sprintf("%X", $int);
    }
}

sub show-space-chars($str) {
    # given a string with space chars, return a version with the
    # hex code shown for them and place a pipe separating all
    # chars in the original string
    my @c = $str.comb;
    my $new-str = '';
    for @c -> $c {
        $new-str ~= '|' if $new-str;
        if $c ~~ /\s/ {
            my $int = $c.ord;
            my $hex-str = int2hexstr($int);
            $new-str ~= $hex-str;
        }
        else {
            =begin comment
            $new-str ~= $c;
            =end comment
            my $int = $c.ord;
            my $hex-str = int2hexstr($int, :plain);
            $new-str ~= $hex-str;
        }
    }
    return $new-str;
}

##### subroutines #####
sub gen-pod {
    my $code = "";
    # my $fh = open $f, :w;
    #LEAVE try close $fh;

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

my $pod = gen-pod;
my $nbchar-count = +@nbchars;
plan $nbchar-count + 1;
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

{
    my $i = 3;
    my $row = 3 + 1;
    my $nbspc = "﻿";
    my $res0 = "Raku{$nbspc}Language is the best!";
    my $res1 = "Raku {$nbspc} Language is the best!";
    # show cell chars separated by pipes
    my $c0 = show-space-chars($r.contents[$i][0]);
    my $r0 = show-space-chars($res0);
    my $c1 = show-space-chars($r.contents[$i][1]);
    my $r1 = show-space-chars($res1);

    is $r.contents[$i][0], $res0, "row $row, col 1: '$c0' vs '$r0'";
    is $r.contents[$i][1], $res1, "row $row, col 2: '$c1' vs '$r1'";
}
# vim: expandtab shiftwidth=4
