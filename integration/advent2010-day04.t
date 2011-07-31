# http://perl6advent.wordpress.com/2010/12/04/the-sequence-operator/

use v6;
use Test;
plan 11;

{
    my @even-numbers  := 0, 2 ... *;    # arithmetic seq
    is @even-numbers[^10].join(" "), "0 2 4 6 8 10 12 14 16 18", "First ten even numbers are correct";
    my @odd-numbers   := 1, 3 ... *;
    is @odd-numbers[^10].join(" "), "1 3 5 7 9 11 13 15 17 19", "First ten odd numbers are correct";
    my @powers-of-two := 1, 2, 4 ... *; # geometric seq
    is @powers-of-two[^10].join(" "), "1 2 4 8 16 32 64 128 256 512", "First ten powers of two are correct";
}

{
    my @Fibonacci := 0, 1, -> $a, $b { $a + $b } ... *;
    is @Fibonacci[^10].join(" "), "0 1 1 2 3 5 8 13 21 34", "First ten Fibonacci numbers are correct";
}

{
    is (1, 1.1 ... 2).join(" "), "1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2", "1, 1.1 ... 2 is correct";
    is (1, 1.1 ... 2.01)[^14].join(" "), "1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2 2.1 2.2 2.3", 
                                         "1, 1.1 ... 2.01 is correct";
}

{
    is (0, 1, -> $a, $b { $a + $b } ... -> $a { $a > 10000 }).join(" "), 
       "0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946",
       "Fibonacci bounded (...) is correct";
    is (0, 1, -> $a, $b { $a + $b } ...^ -> $a { $a > 10000 }).join(" "), 
       "0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765",
       "Fibonacci bounded (...^) is correct";
    is (0, 1, * + * ...^ * > 10000).join(" "), 
       "0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765",
       "Fibonacci bounded (...^) is correct";
}

{
    my @Fibonacci := 0, 1, * + * ... *;
    #?rakudo todo 'nom regression'
    is (@Fibonacci ...^ * > 10000).join(" "),
       "0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765",
       "Fibonacci bounded after the fact is correct";
    #?rakudo skip 'nom regression'
    is @Fibonacci[30], 832040, 'And @Fibonacci is still unbounded';
}

done();
