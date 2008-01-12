use v6-alpha;
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

{ # chop serveral things
    my ($a, $b) = ("bar", "gorch");
    # FIXME: is(eval 'chop($a, $b)', "h", "two chars removed, second returned", :todo);
    is($a, "ba", "first string", :todo);
    is($b, "gorc", "second string", :todo);
};

{ # chop elements of array
    my @array = ("fizz", "buzz");
    is(chop(@array), "z", "two chars removed second returned");
    is(@array[0], "fiz", "first elem", :todo);
    is(@array[1], "buz", "second elem", :todo);
};

{ # chop a hash
    my %hash = ( "key", "value", "other", "blah");

    # FIXME: is(chop(%hash), "h"|"e", "chopping hash returns last char of either value", :todo);
    is(%hash<key>, "valu", "first value chopped", :todo);
    is(%hash<other>, "bla", "second value chopped", :todo);
};
