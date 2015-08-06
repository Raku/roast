use v6;
use Test;

# L<S32::Str/Str/"=item indices">

plan 24;

# Type of return value
isa-ok 'abc'.indices('b')[0], Int;
isa-ok 'abc'.indices('d'), Parcel;
is 'abc'.indices('d').elems, 0, "method did not find anything";
isa-ok indices('abc','b')[0], Int;
isa-ok indices('abc','d'), Parcel;
is indices('abc','d').elems, 0, "sub did not find anything";

is "foo".indices("o"),              (1,2), "meth o simple test, no overlap";
is "foo".indices("oo"),              (1,), "meth oo simple test, no overlap";
is "foo".indices("o", :overlap),    (1,2), "meth o simple test, overlap";
is "foo".indices("oo", :overlap),    (1,), "meth oo simple test, overlap";
is "foo".indices("", ),         (0,1,2,3), "meth empty simple test, no overlap";
is "foo".indices("", :overlap), (0,1,2,3), "meth empty simple test, no overlap";

is indices("foo","o"),              (1,2), "sub o simple test, no overlap";
is indices("foo","oo"),              (1,), "sub oo simple test, no overlap";
is indices("foo","o", :overlap),    (1,2), "sub o simple test, overlap";
is indices("foo","oo", :overlap),    (1,), "sub oo simple test, overlap";
is indices("foo",""),           (0,1,2,3), "sub empty simple test, no overlap";
is indices("foo","", :overlap), (0,1,2,3), "sub empty simple test, no overlap";

is 422.indices(2), (1,2), "coercion with sub";
is indices(422,2), (1,2), "coercion with method";

is indices("uuúuúuùù", "úuù"), (4,), "Accented chars sub";
is indices("Ümlaut", "Ü"),     (0,), "Umlaut sub";
is "uuúuúuùù".indices("úuù"),  (4,), "Accented chars meth";
is "Ümlaut".indices("Ü"),      (0,), "Umlaut meth";

# vim: ft=perl6
