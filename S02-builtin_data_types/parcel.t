use v6;
use Test;

plan 11;

isa_ok (5, 7, 8), Parcel, '(5, 7, 8) is Parcel';
is +(5, 7, 8), 3, 'prefix:<+> on a Parcel';
is ~(5, 7, 8), '5 7 8', 'prefix:<~> on a Parcel';
is (5, 7, 8).Str, '5 7 8', '.Str on a Parcel';

# L<S02/Literals/Elsewhere it is equivalent to a parenthesized list of
# strings>

isa_ok <5 7 8>, Parcel, '<5 7 8> is Parcel';
is +<5 7 8>, 3, 'prefix:<+> on an angle bracket Parcel';
is ~<5 7 8>, '5 7 8', 'prefix:<~> on an angle bracket Parcel';
is <5 7 8>.Str, '5 7 8', '.Str on an angle bracket Parcel';

isa_ok (5, 7, 8).Array, Array, '.Array returns an array';
is (5, 7, 8).Array, [5,7,8], '.Array contains the right items';
is (5, 7, 8).Array.elems, 3, '.Array contains the right number of elements';


# vim: ft=perl6
