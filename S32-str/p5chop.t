use v6;
use Test;

# L<S29/Str/"=item p5chop">

plan 6;

# TODO: tests with "wide" unicode characters

# test with scalar argument

my $test = "abcdefg";

is(p5chop($test), 'g', "p5chop returns the last character");
is($test, "abcdef", "p5chop removes last character");
is(p5chop($test), 'f', "repeated call to p5chop returns the last character each time");
is($test, "abcde", "repeated call to p5chop removes last character");

# array test

my @t = <abc def gih>;

is(p5chop(@t), 'h', 'p5chop(@list) returns the last removed char');
is(@t, <ab de gi>, 'p5chop(@list) removes the last char of each string');
