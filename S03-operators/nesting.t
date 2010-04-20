use v6;
use Test;

plan *;

# L<S03/Meta operators/Nesting of metaoperators/Any infix function may be referred to as a noun either by the normal long form or a short form>

ok &infix:<+>  === &[+],  'long and short form are the same (+)';
ok &infix:<==> === &[==], 'long and short form are the same (==)';
is sort( &[<=>], <5 3 2 1 4> ), <1 2 3 4 5>, 'sort works using &[<=>]';

done_testing;

# vim: ft=perl6
