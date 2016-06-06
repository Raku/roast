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
is $r.contents[0].join(','), 'X,O,';
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
is $r.contents[0].join(','), 'X,O,';
is $r.contents[1].join(','), ',X,O';
is $r.contents[2].join(','), ',,X';

=begin table

foo
bar

=end table

$r = $=pod[8];
is $r.contents.elems, 2;

# TODO: test for issue #128221 when it's closed
#       This test, without the leading'#' in
#       the single table row causes an exception
#       and thus the row needs to be commented
#       out until the issue is closed.
=begin table
#-col1 col2 # <= remove leading '#' when the issue is fixed
=end table
$r = $=pod[9];
skip 'issue #128221 not yet fixed', 1;
is $r.contents.elems, 1;
