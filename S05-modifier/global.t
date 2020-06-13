use v6;
use Test;

plan 9;

=begin description

Testing the C<:global> regex modifier - more tests are always welcome

=end description

{
    my @matches = "hello world".match(/.o/, :g).list;
    is +@matches, 2, "Two matches found";
    is ~(@matches[0]), "lo", "First match is 'lo'";
    is ~(@matches[1]), "wo", "Second match is 'wo'";
}


{
    my @matches = "hello world".match(/foo/, :g).list;
    is +@matches, 0, "Zero matches found";
}

{
    my @matches = "hello world".match(/<[aeiou]>./, :global).list;
    is +@matches, 3, "Three matches found";
    is ~(@matches[0]), "el", "First match is 'el'";
    is ~(@matches[1]), "o ", "Second match is 'o '";
    is ~(@matches[2]), "or", "Third match is 'or'";
}

# https://github.com/rakudo/rakudo/issues/3554
{
    my @got;
    if "test1 test2 test3 test4" ~~ m:g/ (\w+) {} / {
        @got.push(~$_) for $/.list;
    }
    is-deeply @got, ['test1', 'test2', 'test3', 'test4'],
        'm:g/.../ with an embedded {} produces correct results';
}

# vim: expandtab shiftwidth=4
