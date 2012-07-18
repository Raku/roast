use v6;

use Test;

plan 1;

role B { method x { 3; } }

class T does B { }

class S does B
{
        has $.t is rw;
        method x
        {
                $.t.x;
        }
        submethod BUILD(*@_)
        { $!t = T.new }
}

# uncomment below after the bug is fixed. As below line will cause infinite loop;
is S.new.x, 3, "Test class inhrited from the same role caused infinite loop bug";

# vim: ft=perl6
