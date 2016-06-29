use v6;
use Test;
plan 40;
my $r;

=begin table
        The Shoveller   Eddie Stevens     King Arthur's singing shovel
        Blue Raja       Geoffrey Smith    Master of cutlery
        Mr Furious      Roy Orson         Ticking time bomb of fury
        The Bowler      Carol Pinnsler    Haunted bowling ball
=end table

$r = $=pod[0];
isa-ok $r, Pod::Block::Table;
is $r.contents.elems, 4;
is $r.contents[0].join('|'),
   "The Shoveller|Eddie Stevens|King Arthur's singing shovel";
is $r.contents[1].join('|'),
   "Blue Raja|Geoffrey Smith|Master of cutlery";
is $r.contents[2].join('|'),
   "Mr Furious|Roy Orson|Ticking time bomb of fury";
is $r.contents[3].join('|'),
   "The Bowler|Carol Pinnsler|Haunted bowling ball";

=table
    Constants           1
    Variables           10
    Subroutines         33
    Everything else     57

$r = $=pod[1];
is $r.contents.elems, 4;
is $r.contents[0].join('|'), "Constants|1";
is $r.contents[1].join('|'), "Variables|10";
is $r.contents[2].join('|'), "Subroutines|33";
is $r.contents[3].join('|'), "Everything else|57";

=for table
    mouse    | mice
    horse    | horses
    elephant | elephants

$r = $=pod[2];
is $r.contents.elems, 3;
is $r.contents[0].join('|'), "mouse|mice";
is $r.contents[1].join('|'), "horse|horses";
is $r.contents[2].join('|'), "elephant|elephants";

=table
    Animal | Legs |    Eats
    =======================
    Zebra  +   4  + Cookies
    Human  +   2  +   Pizza
    Shark  +   0  +    Fish

$r = $=pod[3];
is $r.headers.join('|'), "Animal|Legs|Eats";
is $r.contents.elems, 3;
is $r.contents[0].join('|'), "Zebra|4|Cookies";
is $r.contents[1].join('|'), "Human|2|Pizza";
is $r.contents[2].join('|'), "Shark|0|Fish";

=table
        Superhero     | Secret          | 
                      | Identity        | Superpower
        ==============|=================|================================
        The Shoveller | Eddie Stevens   | King Arthur's singing shovel

$r = $=pod[4];
is $r.headers.join('|'), "Superhero|Secret Identity|Superpower";
is $r.contents.elems, 1;
is $r.contents[0].join('|'),
   "The Shoveller|Eddie Stevens|King Arthur's singing shovel";

=begin table

                        Secret
        Superhero       Identity          Superpower
        =============   ===============   ===================
        The Shoveller   Eddie Stevens     King Arthur's
                                          singing shovel

        Blue Raja       Geoffrey Smith    Master of cutlery

        Mr Furious      Roy Orson         Ticking time bomb
                                          of fury

        The Bowler      Carol Pinnsler    Haunted bowling ball

=end table

$r = $=pod[5];
is $r.headers.join('|'), "Superhero|Secret Identity|Superpower";
is $r.contents.elems, 4;
is $r.contents[0].join('|'),
   "The Shoveller|Eddie Stevens|King Arthur's singing shovel";
is $r.contents[1].join('|'),
   "Blue Raja|Geoffrey Smith|Master of cutlery";
is $r.contents[2].join('|'),
   "Mr Furious|Roy Orson|Ticking time bomb of fury";
is $r.contents[3].join('|'),
   "The Bowler|Carol Pinnsler|Haunted bowling ball";

=table
    X | O |
   ---+---+---
      | X | O
   ---+---+---
      |   | X

$r = $=pod[6];
is $r.contents.elems, 3;
is $r.contents[0].join(','), 'X,O,',
    'ensure trailing whitespace counts as a cell (WARNING: this test will'
    ~ ' fail if you modified this file and your editor auto-stripped'
    ~ ' trailing whitespace)';
is $r.contents[1].join(','), ',X,O';
is $r.contents[2].join(','), ',,X';

=table
    X   O     
   ===========
        X   O 
   ===========
            X 

$r = $=pod[7];
is $r.contents.elems, 3;
is $r.contents[0].join(','), 'X,O,',
    'ensure trailing whitespace counts as a cell (WARNING: this test will'
    ~ ' fail if you modified this file and your editor auto-stripped'
    ~ ' trailing whitespace)';
is $r.contents[1].join(','), ',X,O';
is $r.contents[2].join(','), ',,X';

=begin table

foo
bar

=end table

$r = $=pod[8];
is $r.contents.elems, 2;

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
    skip 'issue #128221 not yet fixed';
}
else {
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
    skip 'issue #128221 not yet fixed';
}
else {
    is $r.headers.elems, 1;
    is $r.contents.elems, 7;

    my $hdrs = $r.headers.join(' ');
    is $hdrs, "-Col 1 -Col 2 _Col 3 =Col 4"; # <= note leading hyphen which needs to be added to the table
    
    my @rows = $r.contents>>.join(' ');
    is @rows[0], "r0Col 1 -r0Col 2 _r0Col 3 =r0Col 4";
    is @rows[1], "r1Col 1 -r1Col 2 _r1Col 3 =r1Col 4";
    is @rows[2], "r2Col 1 -r2Col 2 _r2Col 3 =r2Col 4";
    is @rows[3], "r3Col 1 -r3Col 2 _r3Col 3 =r3Col 4";
    is @rows[4], "r4Col 1 -r4Col 2 _r4Col 3 =r4Col 4";
    is @rows[5], "r5Col 1 -r5Col 2 _r5Col 3 =r5Col 4";
    is @rows[6], "r6Col 1 r6Col 2 r6Col 3 r6Col 4";
}

