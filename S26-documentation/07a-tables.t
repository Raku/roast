use Test;

my ($r, $p, $hdrs, @rows);
$p = -1; # starting index for pod number

plan 77;

# includes tests for fixes for bugs:
#   incorrect table parse: https://github.com/Raku/old-issue-tracker/issues/3798
#   internal error: https://github.com/Raku/old-issue-tracker/issues/5336
#   uneven rows: https://github.com/Raku/old-issue-tracker/issues/5746
#   pad rows to add empty cells to ensure all rows have same number of cells: https://github.com/Raku/old-issue-tracker/issues/6627
#   handle inline Z<> comments on table rows: https://github.com/Raku/old-issue-tracker/issues/6630

# https://github.com/Raku/old-issue-tracker/issues/3798
# test fix - incorrect table parse:
=table
+-----+----+---+
|   a | b  | c |
+-----+----+---+
| foo | 52 | Y |
| bar | 17 | N |
|  dz | 9  | Y |
+-----+----+---+

$r = $=pod[++$p];
#  tests
is $r.headers.elems, 3;
$hdrs = $r.headers.join('*');
is $hdrs, "a*b*c";
@rows = $r.contents>>.join('*');
is $r.contents.elems, 3;
is @rows[0], "foo*52*Y";
is @rows[1], "bar*17*N";
is @rows[2], "dz*9*Y";

# https://github.com/Raku/old-issue-tracker/issues/5336
# test fix for internal error
#       This test, with a '-r0c0' entry in
#       the single table row, column 0,
#       caused an exception.
=begin table
-r0c0  r0c1
=end table
$r = $=pod[++$p];
is $r.contents.elems, 1;
is $r.contents[0][0], "-r0c0"; # <= note leading hyphen which caused the original issue
is $r.contents[0][1], "r0c1";

# https://github.com/Raku/old-issue-tracker/issues/5746
# an expanded test for uneven rows
# note expected results have been corrected from that time
=begin table
-Col 1 | -Col 2 | _Col 3 | =Col 4
=======+========+========+=======
r0Col 1  | -r0Col 2 | _r0Col 3 | =r0Col 4
-------|--------|--------|-------
r1Col 1  | -r1Col 2 | _r1Col 3 | =r1Col 4
r1       |  r1Col 2 | _r1Col 3 | =r1Col 4
-------|--------|--------|-------
r2Col  1 | r2Col 2  |  r2Col 3 |  r2Col 4
=end table
$r = $=pod[++$p];
$hdrs = $r.headers.join('|');
@rows = $r.contents>>.join('|');

is $r.headers.elems, 4;
is $r.contents.elems, 3;
is $hdrs, "-Col 1|-Col 2|_Col 3|=Col 4"; # <= note leading hyphen which caused the original issue
is @rows[0], "r0Col 1|-r0Col 2|_r0Col 3|=r0Col 4";
is @rows[1], "r1Col 1 r1|-r1Col 2 r1Col 2|_r1Col 3 _r1Col 3|=r1Col 4 =r1Col 4", "test for merged cells";
is @rows[2], "r2Col 1|r2Col 2|r2Col 3|r2Col 4";

# https://github.com/Raku/old-issue-tracker/issues/5746
# uneven rows
=begin table
a | b | c
l | m | n
x | y
=end table

$r = $=pod[++$p];
is $r.contents.elems, 3;
is $r.contents[0].join(','), 'a,b,c';
is $r.contents[1].join(','), 'l,m,n';
is $r.contents[2].join(','), 'x,y,';

is $r.contents[0].elems, 3;
is $r.contents[1].elems, 3;
is $r.contents[2].elems, 3;

# test fix for https://github.com/Raku/old-issue-tracker/issues/6627
# also tests fix for https://github.com/Raku/old-issue-tracker/issues/5746
=table
    X   O
   ===========
        X   O
   ===========
            X

$r = $=pod[++$p];
is $r.contents.elems, 3;
is $r.contents[0].join(','), 'X,O,', "test for empty cell";
is $r.contents[1].join(','), ',X,O';
is $r.contents[2].join(','), ',,X';

is $r.contents[0].elems, 3;
is $r.contents[1].elems, 3;
is $r.contents[2].elems, 3;

# test fix for https://github.com/Raku/old-issue-tracker/issues/6630
# also tests fix for https://github.com/Raku/old-issue-tracker/issues/5746
=begin table
a | b | c
l | m | n
x | y      Z<a comment> Z<another comment>
=end table
$r = $=pod[++$p];
is $r.contents.elems, 3;
is $r.contents[0].join(','), 'a,b,c';
is $r.contents[1].join(','), 'l,m,n';
is $r.contents[2].join(','), 'x,y,';

# a single column table, no headers
=begin table
a
=end table

$r = $=pod[++$p];
is $r.headers.elems, 0;
is $r.contents.elems, 1;

# a single column table, with header
=begin table
b
-
a
=end table

$r = $=pod[++$p];
is $r.headers.elems, 1;
is $r.contents.elems, 1;

# test fix for https://github.com/rakudo/rakudo/issues/1282:
# need to handle table cells with char column separators as data
# example table from <https://docs.raku.org/language/regexes>
# WITHOUT the escaped characters (results in an extra, unwanted, incorrect column)
=begin table

    Operator  |  Meaning
    ==========+=========
     +        |  set union
     |        |  set union
     &        |  set intersection
     -        |  set difference (first minus second)
     ^        |  symmetric set intersection / XOR

=end table

$r = $=pod[++$p];
is $r.headers.elems, 3;
$hdrs = $r.headers.join(',');
is $hdrs, "Operator,Meaning,";
is $r.contents.elems, 5;
@rows = $r.contents>>.join(',');
is @rows[0], ",,set union";
#?rakudo todo 'unescaped | should act as a column divider'
is @rows[1], ",,set union";
is @rows[2], "&,set intersection,";
is @rows[3], "-,set difference (first minus second),";
is @rows[4], "^,symmetric set intersection / XOR,";

# WITH the escaped characters (results in the desired table)
=begin table

    Operator  |  Meaning
    ==========+=========
     \+       |  set union
     \|       |  set union
     &        |  set intersection
     -        |  set difference (first minus second)
     ^        |  symmetric set intersection / XOR

=end table

$r = $=pod[++$p];
is $r.headers.elems, 2;
$hdrs = $r.headers.join(',');
is $hdrs, "Operator,Meaning";
is $r.contents.elems, 5;
@rows = $r.contents>>.join(',');
is @rows[0], "+,set union";
is @rows[1], "|,set union";
is @rows[2], "&,set intersection";
is @rows[3], "-,set difference (first minus second)";
is @rows[4], "^,symmetric set intersection / XOR";

# WITH the escaped characters but without the non-breaking spaces
# (results in the desired table)

=begin table

    Operator  |  Meaning
    ==========+=========
    \+       |  set union
    \|       |  set union
    &       |  set intersection
    -       |  set difference (first minus second)
    ^       |  symmetric set intersection / XOR

=end table

$r = $=pod[++$p];
is $r.headers.elems, 2;
$hdrs = $r.headers.join(',');
is $hdrs, "Operator,Meaning";
is $r.contents.elems, 5;
@rows = $r.contents>>.join(',');
is @rows[0], "+,set union";
is @rows[1], "|,set union";
is @rows[2], "&,set intersection";
is @rows[3], "-,set difference (first minus second)";
is @rows[4], "^,symmetric set intersection / XOR";

# fix for GH #1821: unexpected table failure with mixed vis and non-vis
# column separators

=begin table

    Type    | Comments
    ========+================================================
    Complex |
    Num     |
    FatRat  |
    MidRat  | Special infectiousness. See prose that follows.
    Rat     |
    Int     |

=end table

$r = $=pod[++$p];
is $r.headers.elems, 2;
$hdrs = $r.headers.join(',');
is $hdrs, "Type,Comments";
is $r.contents.elems, 6;
@rows = $r.contents>>.join(',');
is @rows[0], "Complex,";
is @rows[1], "Num,";
is @rows[2], "FatRat,";
is @rows[3], "MidRat,Special infectiousness. See prose that follows.";
is @rows[4], "Rat,";
is @rows[5], "Int,";

# a variant table using the '+' visual column separator

=begin table

    Type    | Comments
    ========+================================================
    Num     +
    MidRat  | Special infectiousness. See prose that follows.
    Rat     |
    Int     +

=end table

$r = $=pod[++$p];
is $r.headers.elems, 2;
$hdrs = $r.headers.join(',');
is $hdrs, "Type,Comments";
is $r.contents.elems, 4;
@rows = $r.contents>>.join(',');
is @rows[0], "Num,";
is @rows[1], "MidRat,Special infectiousness. See prose that follows.";
is @rows[2], "Rat,";
is @rows[3], "Int,";

# vim: expandtab shiftwidth=4
