use v6;
use Test;
plan 6;

# L<S32::Str/Str/ords>

is ords('').elems, 0, 'ords(empty string)';
is ''.ords.elems,  0, '<empty string>.ords';
is ords('Cool()').join(', '), '67, 111, 111, 108, 40, 41',
   'ords(normal string)';
is 'Cool()'.ords.join(', '), '67, 111, 111, 108, 40, 41',
   '<normal string>.ords';
is ords(42).join(', '), '52, 50', 'ords() on integers';
is 42.ords.join(', '), '52, 50', '.ords on integers';
