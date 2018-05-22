use v6;

use MONKEY-SEE-NO-EVAL;
use Test;

my $f = './.tmp-test-file2';

my $code = gen-test($f);

EVAL $code;

##### subroutines #####
sub gen-test($f) {
    my $fh = open $f, :w;

    $fh.print: q:to/HERE/;
    use v6;

    use Test;

    plan 19;
    my $r;

    # one-column table with various whitespace chars
    =table
    HERE

    # non-breaking ws chars
    my @nbchars = <
       0x00A0
       0x202F
    >;
    # breaking ws chars
    my @bchars = <
        0x0009
        0x0020
        0x1680
        0x2000
        0x2001
        0x2002
        0x2003
        0x2004
        0x2005
        0x2006
        0x2007
        0x2008
        0x2009
        0x200A
        0x205F
        0x3000
    >;

    # first row
    my $row1 = "Perl";
    $row1 ~= @nbchars[0].chr;
    $row1 ~= "6";
    for @bchars -> $c {
        $row1 ~= $c.chr;
    }
    $row1 ~= "is the best!";
    $fh.say: $row1;

    # last row
    my $row2 = "Perl";
    #my $row2 .~ @nbchars[1].chr;
    $row2 ~= " ";
    $row2 ~= "6";
    for @bchars -> $c {
        $row2 ~= $c.chr;
    }
    $row2 ~= "is the best!";
    $fh.say: $row2;
    $fh.say;

    $fh.say: "my \$res0  = \"Perl{@nbchars[0].chr}6 is the best!\";";
    $fh.say: "my \$res1  = \"Perl{@nbchars[1].chr}6 is the best!\";";
    $fh.say: "my \$nbsp0 = \"{@nbchars[0].chr}\";";
    $fh.say: "my \$nbsp1 = \"{@nbchars[1].chr}\";";
    $fh.say: "my \$nbsp0 = \"{@nbchars[0].chr}\";";
    $fh.say: "my \$space = \"{@bchars[1].chr}\";";
    $fh.print: q:to/HERE/;
    $r = $=pod[0];
    is $r.contents.elems, 2, "table has 2 elements (rows)";

    is $r.contents[0], $res0, "row 1: '$res0'";
    my @c0 = $r.contents[0].comb;

    is @c0[4], $nbsp0, "char[4] is: {$nbsp0.ord.base(16)}";
    is @c0[4].ord.base(16), $nbsp0.ord.base(16), "char[4] is: {$nbsp0.ord.base(16)}";

    is @c0[6], $space, "char[6] is: {$space.ord.base(16)}";
    is @c0[6].ord.base(16), $space.ord.base(16), "char[6] is: {$space.ord.base(16)}";
    is @c0[9], $space, "char[9] is: {$space.ord.base(16)}";
    is @c0[9].ord.base(16), $space.ord.base(16), "char[9] is: {$space.ord.base(16)}";
    is @c0[13], $space, "char[13] is: {$space.ord.base(16)}";
    is @c0[13].ord.base(16), $space.ord.base(16), "char[13] is: {$space.ord.base(16)}";

    is $r.contents[1], $res1, "row 2: '$res1'";
    my @c1 = $r.contents[1].comb;
    is @c1[4], $nbsp1, "char[4] is: {$nbsp1.ord.base(16)}";
    is @c1[4].ord.base(16), $nbsp1.ord.base(16), "char[4] is: {$nbsp1.ord.base(16)}";

    is @c1[6], $space, "char[6] is: {$space.ord.base(16)}";
    is @c1[6].ord.base(16), $space.ord.base(16), "char[6] is: {$space.ord.base(16)}";
    is @c1[9], $space, "char[9] is: {$space.ord.base(16)}";
    is @c1[9].ord.base(16), $space.ord.base(16), "char[9] is: {$space.ord.base(16)}";
    is @c1[13], $space, "char[13] is: {$space.ord.base(16)}";
    is @c1[13].ord.base(16), $space.ord.base(16), "char[13] is: {$space.ord.base(16)}";

    HERE

    $fh.close;

    return slurp $f;
}

=begin comment
# expand tests to include all space chars, from the code:
# unicode hex values and names for the 17 space characters (unicode property Zs)
# (from ftp://ftp.unicode.org/Public/UNIDATA/UnicodeData.txt):
#   U-0020 SPACE
#   U-00A0 NO-BREAK SPACE              <= to be excluded from breaking space set
#   U-1680 OGHAM SPACE MARK
#   U-2000 EN QUAD
#   U-2001 EM QUAD
#   U-2002 EN SPACE
#   U-2003 EM SPACE
#   U-2004 THREE-PER-EM SPACE
#   U-2005 FOUR-PER-EM SPACE
#   U-2006 SIX-PER-EM SPACE
#   U-2007 FIGURE SPACE
#   U-2008 PUNCTUATION SPACE
#   U-2009 THIN SPACE
#   U-200A HAIR SPACE
#   U-202F NARROW NO-BREAK SPACE       <= to be excluded from breaking space set
#   U-205F MEDIUM MATHEMATICAL SPACE
#   U-3000 IDEOGRAPHIC SPACE
#
# unicode hex values and names for other horizontal breaking space characters of interest
#   U-0009 CHARACTER TABULATION
#
# the resulting regex (16 chars):
#    my $breaking-spaces-regex := /<[
#                                     \x[0009]
#                                     \x[0020]
#                                     \x[1680]
#                                     \x[2000] .. \x[200A]
#                                     \x[205F]
#                                     \x[3000]
#                                   ]>+/;
=end comment

END { unlink $f }
