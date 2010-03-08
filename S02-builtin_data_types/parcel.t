use v6;
use Test;

plan 8;

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


# vim: ft=perl6
