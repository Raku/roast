use v6;

use Test;

=begin pod

=head1 String interpolation

These tests derived from comments in L<http://use.perl.org/~autrijus/journal/23398>

=end pod

plan 43;

my $world = "World";
my $number = 1;
my @list  = (1,2);
my %hash  = (1=>2);
sub func { return "func-y town" }
sub func_w_args($x,$y) { return "[$x][$y]" }

# Double quotes
is("Hello $world", 'Hello World', 'double quoted string interpolation works');
is("@list[]\ 3 4", '1 2 3 4', 'double quoted list interpolation works');
is("@list 3 4", '@list 3 4', 'array without empty square brackets does not interpolate');
#?rakudo skip 'zen hash slice'
is("%hash{}", "1\t2\n", 'hash interpolation works');
is("%hash", '%hash', 'hash interpolation does not work if not followed by {}');
is("Wont you take me to &func()", 'Wont you take me to func-y town', 'closure interpolation');
is("2 + 2 = { 2+2 }", '2 + 2 = 4', 'double quoted closure interpolation works');

is("&func() is where I live", 'func-y town is where I live', "make sure function interpolation doesn't eat all trailing whitespace");
is("$number {$number}", '1 1', 'number inside and outside closure works');
is("$number {my $number=2}", '1 2', 'local version of number in closure works');
is("$number {my $number=2} $number", '1 2 1', 'original number still available after local version in closure: works' );

{
    is "$(my $x = 2) $x", '2 2', 'Variable should interpolate and still be available in the outer scope.';
    is("$(my $y = 2)" ~ $y, '22', 'Variable should interpolate and still be available in the outer scope.');
}

# L<S02/Names and Variables/form of each subscript>
is("&func. () is where I live", '&func. () is where I live', '"&func. ()" should not interpolate');
is("&func_w_args("foo","bar"))", '[foo][bar])', '"&func_w_args(...)" should interpolate');

# L<S02/Literals/"In order to interpolate the result of a method call">
is("$world.chars()", '5', 'method calls with parens should interpolate');
is("$world.chars", 'World.chars', 'method calls without parens should not interpolate');
is("$world.flip.chars()", '5', 'cascade of argumentless methods, last ending in paren');
is("$world.substr(0,1)", 'W', 'method calls with parens and args should interpolate');

# Single quotes
# XXX the next tests will always succeed even if '' interpolation is buggy
is('Hello $world', 'Hello $world', 'single quoted string interpolation does not work (which is correct)');
is('2 + 2 = { 2+2 }', '2 + 2 = { 2+2 }', 'single quoted closure interpolation does not work (which is correct)');
is('$world @list[] %hash{} &func()', '$world @list[] %hash{} &func()', 'single quoted string interpolation does not work (which is correct)');

# Corner-cases
is("Hello $world!", "Hello World!", "! is not a part of var names");
sub list_count (*@args) { +@args }
#?rakudo todo 'nom regression'
is(list_count("@list[]"), 1, 'quoted interpolation gets string context');
is(qq{a{chr 98}c}, 'abc', "curly brace delimiters don't interfere with closure interpolation");

# Quoting constructs
# The next test will always succeed, but if there's a bug it probably
# won't compile.
is(Q"abc\\d\\'\/", Q"abc\\d\\'\/", "raw quotation works");
is(q"abc\\d\"\'\/", Q|abc\d"\'\/|, "single quotation works"); #"
is(qq"abc\\d\"\'\/", Q|abc\d"'/|, "double quotation works"); #"
#?rakudo 3 skip 'qa qb and array/hash interpolation'
is(qa"$world @list[] %hash{}", Q"$world 1 2 %hash{}", "only interpolate array");
is(qb"$world \\\"\n\t", "\$world \\\"\n\t", "only interpolate backslash");
is('$world \qq[@list[]] %hash{}', '$world 1 2 %hash{}', "interpolate quoting constructs in ''");

is(" \c[111] \c[107] ", ' o k ', "\\c[] respects whitespaces around it");

# L<S02/Literals/separating the numbers with comma:>
is("x  \x[41,42,43]  x",     "x  ABC  x",  "\\x[] allows multiple chars (1)");
is("x  \x[41,42,00043]  x",  "x  ABC  x",  "\\x[] allows multiple chars (2)");   #OK not indicate octal
is("x  \x[ 41, 42, 43 ]  x", "x  ABC  x",  "\\x[] allows multiple chars with white space");
is("x  \c[65,66,67]  x",     "x  ABC  x",  "\\c[] allows multiple chars (1)");
is("x  \c[65,66,000067]  x", "x  ABC  x",  "\\c[] allows multiple chars (2)");   #OK not indicate octal
is("x  \c[ 65, 66, 67 ]  x", "x  ABC  x",  "\\c[] allows multiple chars with white space");

is("x  \x[41,42,43]]  x",    "x  ABC]  x", "\\x[] should not eat following ]s");
is("x  \c[65,66,67]]  x",    "x  ABC]  x", "\\c[] should not eat following ]s");

# L<S12/Fancy method calls/Within an interpolation, the double-quoted form>
{
    class InterpolationTest {
        method f { 'int' }
    }
    my $x = InterpolationTest.new;

    # ORLY, STD.pm parses that as an indirect method call. It will warn,
    # but strictly speaking it's legal.
    is "|$x.'f'()|", '|int|',    #OK use of quotes
       'interpolation of indirect method calls (different quotes)';
    is "|$x."f"()|", '|int|',    #OK use of quotes
       'interpolation of indirect method calls (same quotes)';
    eval_dies_ok q["|$x."f "()"], '... but whitespaces are not allowed';
}

# vim: ft=perl6
