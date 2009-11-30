use v6;
use Test;

# L<S32::Str/Str/"=item chop">

plan 13;

#
# Tests already covered by the specs
#

my $str = "foo";
is(chop($str), "fo", "o removed");
#?rakudo skip 'calling positional args by name'
is(chop(:string($str)), "fo", "chop works with named arguments");
is($str, "foo", "original string unchanged");

is($str.chop, "fo", "o removed");
is($str, "foo", "original string unchanged");

is(chop("bar"), "ba", "chop on string literal");
is(chop(""), "", "chop on empty string literal");

# TODO: catch warning, what should be the return value ?
# my $undef_scalar;
# chop($undef_scalar)


# See L<"http://use.perl.org/~autrijus/journal/25351">:
#   &chomp and &wrap are now nondestructive; chomp returns the chomped part,
#   which can be defined by the filehandle that obtains the default string at
#   the first place. To get destructive behaviour, use the .= form.

=begin more-discussion-needed

XXX: chop(@array) should return an array of chopped strings?
XXX: chop(%has)   should return a  hash  of chopped strings?

=end more-discussion-needed

#?rakudo skip "unspecced"
{ # chop several things
    my ($a, $b) = ("bar", "gorch");
#?pugs 3 todo ''
    is(chop($a, $b), "h", "two chars removed, second returned");
    is($a, "ba", "first string");
    is($b, "gorc", "second string");
};

#?rakudo skip "unspecced"
{ # chop elements of array
    my @array = ("fizz", "buzz");
    is(chop(@array), "z", "two chars removed second returned");
#?pugs 2 todo 'unspecced'
    is(@array[0], "fiz", "first elem");
    is(@array[1], "buz", "second elem");
};

# vim: ft=perl6
