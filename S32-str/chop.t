use v6;
use Test;

# L<S32::Str/Str/"=item chop">

plan 12;

#
# Tests already covered by the specs
#

my $str = "foo";
is(chop($str), "fo", "o removed");
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

# vim: ft=perl6
