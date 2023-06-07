use MONKEY-SEE-NO-EVAL;
use Test;

my $f = './.tmp-test-file';

my $code = gen-test($f);

EVAL $code;

##### subroutines #####
sub gen-test($f) {
    my $fh = open $f, :w;

    $fh.print: q:to/HERE/;
    use Test;

    plan 8;
    my $r;

    # table with no ending ws
    =table
    HERE

    $fh.say: "    X | O |";

    $fh.print: q:to/HERE/;
       ---+---+---
          | X | O
       ---+---+---
          |   | X


    # table with ending ws
    =table
    HERE

    $fh.say: "    X | O | ";

    $fh.print: q:to/HERE/;
       ---+---+---
          | X | O
       ---+---+---
          |   | X


    $r = $=pod[0];
    is $r.contents.elems, 3;
    is $r.contents[0].join(','), 'X,O,';
    is $r.contents[1].join(','), ',X,O';
    is $r.contents[2].join(','), ',,X';

    $r = $=pod[1];
    is $r.contents.elems, 3;
    is $r.contents[0].join(','), 'X,O,';
    is $r.contents[1].join(','), ',X,O';
    is $r.contents[2].join(','), ',,X';
    HERE

    $fh.close;

    return slurp $f;
}

END { unlink $f }

# vim: expandtab shiftwidth=4
