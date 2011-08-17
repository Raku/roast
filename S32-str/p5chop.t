use v6;
use Test;

# L<S32::Str/Str/"=item p5chop">

plan 9;

# TODO: tests with "wide" unicode characters

# test with scalar argument

my $test = "abcdefg";

is(p5chop($test), 'g', "p5chop returns the last character");
is($test, "abcdef", "p5chop removes last character");
is(p5chop($test), 'f', "repeated call to p5chop returns the last character each time");
is($test, "abcde", "repeated call to p5chop removes last character");

# array test

my @t = <abc def gih>;

#?rakudo 2 skip 'p5chop(@list)'
is(p5chop(@t), 'h', 'p5chop(@list) returns the last removed char');
is(@t, [<ab de gi>], 'p5chop(@list) removes the last char of each string');

$test = "abc";
is(p5chop($test), 'c', 'p5chop on literal string');

# TODO: make sure this is a warning:
# my $undef_var;
# p5chop($undef_var)

#?rakudo skip 'p5chop(@list)'
{
	my @empty_array;
	my $r = p5chop(@empty_array);
	ok(defined($r), 'defined');
	is($r, '', 'p5chop on empty array returns empty string');
}




# vim: ft=perl6
