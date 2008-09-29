use v6;

use Test;

plan 6;

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
