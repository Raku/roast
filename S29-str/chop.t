use v6;
use Test;

# L<S29/Str/"=item chop">

plan 2;

#
# Tests already covered by the specs
#

my $str = "foo";
is(chop($str), "fo", "o removed");
is($str, "foo", "original string unchanged");

# See L<"http://use.perl.org/~autrijus/journal/25351">:
#   &chomp and &wrap are now nondestructive; chomp returns the chomped part,
#   which can be defined by the filehandle that obtains the default string at
#   the first place. To get destructive behaviour, use the .= form.

=begin more-discussion-needed

XXX: chop(@array) should return an array of chopped strings?
XXX: chop(%has)   should return a  hash  of chopped strings?

=end more-discussion-needed

{ # chop serveral things
    my ($a, $b) = ("bar", "gorch");
#?pugs 2 todo ''
    # FIXME: is(eval 'chop($a, $b)', "h", "two chars removed, second returned");
    is($a, "ba", "first string");
    is($b, "gorc", "second string");
};

{ # chop elements of array
    my @array = ("fizz", "buzz");
    is(chop(@array), "z", "two chars removed second returned");
#?pugs 2 todo 'unspecified'
    is(@array[0], "fiz", "first elem");
    is(@array[1], "buz", "second elem");
};

{ # chop a hash
    my %hash = ( "key", "value", "other", "blah");

#?pugs 2 todo ''
#?rakudo 2 skip "can't parse"
    # FIXME: is(chop(%hash), "h"|"e", "chopping hash returns last char of either value");
    is(%hash<key>, "valu", "first value chopped");
    is(%hash<other>, "bla", "second value chopped");
};
