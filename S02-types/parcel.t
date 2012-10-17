use v6;
use Test;

plan 15;

isa_ok (5, 7, 8), Parcel, '(5, 7, 8) is Parcel';
is +(5, 7, 8), 3, 'prefix:<+> on a Parcel';
is ~(5, 7, 8), '5 7 8', 'prefix:<~> on a Parcel';
is (5, 7, 8).Str, '5 7 8', '.Str on a Parcel';

# L<S02/Quoting forms/Elsewhere it is equivalent to a parenthesized list of strings>

isa_ok <5 7 8>, Parcel, '<5 7 8> is Parcel';
is +<5 7 8>, 3, 'prefix:<+> on an angle bracket Parcel';
is ~<5 7 8>, '5 7 8', 'prefix:<~> on an angle bracket Parcel';
is <5 7 8>.Str, '5 7 8', '.Str on an angle bracket Parcel';

#?niecza 3 skip 'Unable to resolve method Array in class Parcel'
isa_ok (5, 7, 8).Array, Array, '.Array returns an array';
is (5, 7, 8).Array, [5,7,8], '.Array contains the right items';
is (5, 7, 8).Array.elems, 3, '.Array contains the right number of elements';

is ?(), False, 'empty Parcel is False';
is ?(1,2,3), True, 'non-empty Parcel is True';

lives_ok { <5 7 8>[] }, 'can zen slice a Parcel';

# RT #115282
is (;).elems, 0, '(;) parses, and is empty';

# vim: ft=perl6
