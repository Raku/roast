use v6.c;
use Test;

plan 22;

is (1, |(2,3), 4).gist, '(1 2 3 4)', "simple | middle";
is (|(2,3), 4).gist, '(2 3 4)', "simple | left";
is (1, |(2,3)).gist, '(1 2 3)', "simple | right";

is (1, slip(2,3), 4).gist, '(1 2 3 4)', "simple slip middle";
is (slip(2,3), 4).gist, '(2 3 4)', "simple slip left";
is (1, slip(2,3)).gist, '(1 2 3)', "simple slip right";

is (1, Slip(2,3), 4).gist, '(1 2 3 4)', "simple Slip coercion middle";
is (Slip(2,3), 4).gist, '(2 3 4)', "simple Slip coercion left";
is (1, Slip(2,3)).gist, '(1 2 3)', "simple Slip coercion right";

is (1, (2,3).Slip, 4).gist, '(1 2 3 4)', "simple Slip coercion middle";
is ((2,3).Slip, 4).gist, '(2 3 4)', "simple Slip coercion left";
is (1, (2,3).Slip).gist, '(1 2 3)', "simple Slip coercion right";

is (1, slip (2,3), 4).gist, '(1 (2 3) 4)', "simple slip listop middle";
is (slip (2,3), 4).gist, '((2 3) 4)', "simple slip listop left";
is (1, slip (2,3)).gist, '(1 2 3)', "simple slip listop right";

is (1, slip flat (2,3), 4).gist, '(1 2 3 4)', "slip flat listops middle";
is (slip flat (2,3), 4).gist, '(2 3 4)', "slip flat listops left";
is (1, slip flat (2,3)).gist, '(1 2 3)', "slip flat listops right";

# one-arg lazies, not limited to 65536 elems
{
    my \a = 0, ([\+] 1..*).Slip;
    is a[100000], 5000050000, ".Slip can slip a long lazy list";

    my \b = 0, Slip([\+] 1..*);
    is b[100000], 5000050000, "Slip() can slip a one-arg long lazy list";

    my \c = 0, slip [\+] 1..*;
    is c[100000], 5000050000, "slip works with one-arg long lazy";

    my \d = 0, |[\+] 1..*;
    is d[100000], 5000050000, "prefix:<|> works with one-arg long lazy";
}
