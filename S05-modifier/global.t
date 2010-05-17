use v6;
use Test;

plan *;

=begin description

Testing the C<:global> regex modifier - more tests are always welcome

=end description

{
    my @matches = "hello world".match(/.o/, :g);
    is +@matches, 2, "Two matches found";
    is ~(@matches[0]), "lo", "First match is 'lo'";
    is ~(@matches[1]), "wo", "Second match is 'wo'";
}

{
    my @matches = "hello world".match(/wo/, :g);
    is +@matches, 1, "One match found";
    is ~(@matches[0]), "wo", "First match is 'wo'";
}


{
    my @matches = "hello world".match(/foo/, :g);
    is +@matches, 0, "Zero matches found";
}

done_testing;

# vim: syn=perl6 sw=4 ts=4 expandtab
