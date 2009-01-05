use v6;

use Test;

plan 5;

# L<S03/Comma operator precedence/the Perl 5 fatarrow>

{
    my @arr = 1 p5=> 2 p5=> 3 p5=> 4;
    is(@arr, <1 2 3 4>, 'p5=> works like a comma');
}

ok((1 p5=> 2) !~~ Pair, 'p5=> does not construct a Pair');

{
    sub whatever {
        is(@_.join('|'), 'a|b|c|d', 'arguments passed via p5=> are positional, not named');
        is(%_.keys.elems, 0, 'arguments passed via p5=> do not appear in %_');
    }

    whatever('a' p5=> 'b', 'c' p5=> 'd');
}

# S03:1465 says that p5=> is the same as a comma
# We'll test that it doesn't quote the LHS.

isnt(eval('my @arr = abc p5=> def;'), <abc def>, 'p5=> does not quote the LHS');
