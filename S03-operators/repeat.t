use v6;

use Test;

=begin description

Repeat operators for strings and lists

=end description

plan 29;

#L<S03/Changes to Perl 5 operators/"x (which concatenates repetitions of a string to produce a single string">

is('a' x 3, 'aaa', 'string repeat operator works on single character');
is('ab' x 4, 'abababab', 'string repeat operator works on multiple character');
is(1 x 5, '11111', 'number repeat operator works on number and creates string');
is('' x 6, '', 'repeating an empty string creates an empty string');
is('a' x 0, '', 'repeating zero times produces an empty string');
#?rakudo skip 'nom regression'
is('a' x -1, '', 'repeating negative times produces an empty string');

#L<S03/Changes to Perl 5 operators/"and xx (which creates a list of repetitions of a list or item)">
my @foo = 'x' xx 10;
is(@foo[0], 'x', 'list repeat operator created correct array');
is(@foo[9], 'x', 'list repeat operator created correct array');
is(+@foo, 10, 'list repeat operator created array of the right size');


lives_ok { my @foo2 = Mu xx 2; }, 'can repeat Mu';
my @foo3 = (1, 2) xx 2;
is(@foo3[0], 1, 'can repeat lists');
is(@foo3[1], 2, 'can repeat lists');
is(@foo3[2], 1, 'can repeat lists');
is(@foo3[3], 2, 'can repeat lists');

my @foo4 = 'x' xx 0;
is(+@foo4, 0, 'repeating zero times produces an empty list');

my @foo5 = 'x' xx -1;
is(+@foo5, 0, 'repeating negative times produces an empty list');

my @foo_2d = [1, 2] xx 2; # should create 2d
#?pugs todo 'bug'
#?rakudo todo 'over-flattening'
is(@foo_2d[1], [1, 2], 'can create 2d arrays'); # creates a flat 1d array
# Wrong/unsure: \(1, 2) does not create a ref to the array/list (1,2), but
# returns a list containing two references, i.e. (\1, \2).
#my @foo_2d2 = \(1, 2) xx 2; # just in case it's a parse bug
##?pugs todo 'bug'
#is(@foo_2d[1], [1, 2], 'can create 2d arrays (2)'); # creates a flat 1d array

# test x=
my $twin = 'Lintilla';
ok($twin x= 2, 'operator x= for string works');
is($twin, 'LintillaLintilla', 'operator x= for string repeats correct');

{
    my @array = (4, 2);
    #?rakudo skip 'nom regression'
    ok(@array xx= 2, 'operator xx= for list works');
    is(@array[0], 4, 'operator xx= for list repeats correct');
    #?rakudo todo 'nom regression'
    is(@array[3], 2, 'operator xx= for list repeats correct');
    #?rakudo todo 'nom regression'
    is(+@array, 4, 'operator xx= for list created the right size');
}

# test that xx actually creates independent items
#?DOES 4
{
    my @a = 'a' xx 3;
    is @a.join('|'), 'a|a|a', 'basic infix:<xx>';
    @a[0] = 'b';
    is @a.join('|'), 'b|a|a', 'change to one item left the others unchanged';

    my @b = <x y> xx 3;
    is @b.join('|'), 'x|y|x|y|x|y', 'basic sanity with <x y> xx 3';
    @b[0] = 'z';
    @b[3] = 'a';
    is @b.join('|'), 'z|y|x|a|x|y', 'change to one item left the others unchanged';
}


# tests for non-number values on rhs of xx (RT #76720)
#?rakudo skip 'nom regression'
#?DOES 2
{
    # make sure repeat numifies rhs, but respects whatever
    my @a = <a b c>;
    is(("a" xx @a).join('|'), 'a|a|a', 'repeat properly numifies rhs');

    my @b = <a b c> Z (1 xx *);
    is(@b.join('|'), 'a|1|b|1|c|1', 'xx understands Whatevers');
}


# vim: ft=perl6
