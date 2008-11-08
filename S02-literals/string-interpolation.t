use v6;

use Test;

plan 8;

{
    # The code of the closure takes a reference to the number 1, discards it
    # and finally returns 42.
    is "{\01;42}", "42", '{\\01 parses correctly (1)';
    is "{;\01;42}", "42", '{\\01 parses correctly (2)';
    is "{;;;;;;\01;42}", "42", '{\\01 parses correctly (3)';
}

{
    is "{\1;42}", "42", '{\\1 parses correctly (1)';
    is "{;\1;42}", "42", '{\\1 parses correctly (2)';
    is "{;;;;;;\1;42}", "42", '{\\1 parses correctly (3)';
}

{
    # interpolating into double quotes results in a Str
    my $a = 3;
    ok "$a" ~~ Str, '"$a" results in a Str';
    ok "{3}" ~~ Str, '"{3}" results in a Str';
}
