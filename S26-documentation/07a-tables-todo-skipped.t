use v6;
use Test;
my $r;

# tables here are skipped until appropriate fixes are made

# TODO: test for issue #128221 when it's closed
#       This test, with a '-r0c0' entry in
#       the single table row, column 0,
#       causes an exception and thus the leading
#       hyphen needs to be removed until the issue is
#       closed.
=begin table
r0c0  r0c1
=end table
$r = $=pod[9];
my $issue-N128221-fixed = False;
if !$issue-N128221-fixed  {
    skip 'issue #128221 not yet fixed', 3;
}
else {
    # 3 tests
    is $r.contents.elems, 1;
    is $r.contents[0][0], "-r0c0"; # <= note leading hyphen which needs to be added to the table
    is $r.contents[0][1], "r0c1";
}

# TODO: an expanded test (per Zoffix) for issue #128221
#       when it's closed.
#       This test is for other table parsing issues
#       discovered in Zoffix's work on the problem.
#       As in the previous test, the first cell in the header
#       should have a leading hyphen added ('Col 1' => '-Col 1')
#       to fully test the fix.
=begin table
Col 1 | -Col 2 | _Col 3 | =Col 4
=======+========+========+=======
r0Col 1  | -r0Col 2 | _r0Col 3 | =r0Col 4
-------|--------|--------|-------
r1Col 1  | -r1Col 2 | _r1Col 3 | =r1Col 4
r2Col 1  | -r2Col 2 | _r2Col 3 | =r2Col 4
 r3Col 1 | -r3Col 2 | _r3Col 3 | =r3Col 4
r4Col 1  | -r4Col 2 | _r4Col 3 | =r4Col 4
r5Col 1  | -r5Col 2 | _r5Col 3 | =r5Col 4
-------|--------|--------|-------
r6Col  1 | r6Col 2  |  r6Col 3 |  r6Col 4
=end table
$r = $=pod[10];
my $issue-N128221-fixed-b = False;
if !$issue-N128221-fixed-b  {
    skip 'issue #128221 not yet fixed', 10;
}
else {
    my $hdrs = $r.headers.join(' ');
    my @rows = $r.contents>>.join(' ');

    # 10 tests
    is $r.headers.elems, 1;
    is $r.contents.elems, 7;
    is $hdrs, "-Col 1 -Col 2 _Col 3 =Col 4"; # <= note leading hyphen which needs to be added to the table
    is @rows[0], "r0Col 1 -r0Col 2 _r0Col 3 =r0Col 4";
    is @rows[1], "r1Col 1 -r1Col 2 _r1Col 3 =r1Col 4";
    is @rows[2], "r2Col 1 -r2Col 2 _r2Col 3 =r2Col 4";
    is @rows[3], "r3Col 1 -r3Col 2 _r3Col 3 =r3Col 4";
    is @rows[4], "r4Col 1 -r4Col 2 _r4Col 3 =r4Col 4";
    is @rows[5], "r5Col 1 -r5Col 2 _r5Col 3 =r5Col 4";
    is @rows[6], "r6Col 1 r6Col 2 r6Col 3 r6Col 4";
}


done-testing
