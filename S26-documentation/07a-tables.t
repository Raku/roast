use v6;
use Test;

my ($r, $p, $hdrs, @rows);
$p = -1; # starting index for pod number

plan 33;

# includes tests for fixes for RT bugs:
#   124403 - incorrect table parse:
#   128221 - internal error
#   129862 - uneven rows
#   132341 - pad rows to add empty cells to ensure all rows have same number of cells
#   132348 - handle inline Z<> comments on table rows

# test fix for RT #124403 - incorrect table parse:
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

# test fix for RT #128221
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

# an expanded test (per Zoffix) for issue #128221
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

# test fix for issue RT #129862
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

# test fix for RT #132341
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

# test fix for RT #132348 (allow inline Z comments)
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
