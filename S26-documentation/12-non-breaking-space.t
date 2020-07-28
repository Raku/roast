use v6;

use Test;

use lib $?FILE.IO.parent(2).add('packages/Test-Helpers/lib');
use Test::Misc :int2hexstr, :show-space-chars;

plan 9;

# two-column table with various whitespace chars
=begin table
Raku Language	  ᠎            　is the best! | Raku   Language	  ᠎            　is the best!
Raku Language	  ᠎            　is the best! | Raku   Language	  ᠎            　is the best!
Raku⁠Language	  ᠎            　is the best! | Raku ⁠ Language	  ᠎            　is the best!
Raku﻿Language	  ᠎            　is the best! | Raku ﻿ Language	  ᠎            　is the best!
=end table

my $n = 4;
my $SPACE = ' ';
my $r = $=pod[0];
is $r.contents.elems, $n, "table has $n elements (rows)";

{
    my $i = 0;
    my $row = 0 + 1;
    my $nbspc = " ";
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

{
    my $i = 1;
    my $row = 1 + 1;
    my $nbspc = " ";
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

{
    my $i = 2;
    my $row = 2 + 1;
    my $nbspc = "⁠";
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
