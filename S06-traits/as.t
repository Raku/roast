use v6;

use Test;

plan 5;

=begin description

Testing C<as> trait (coercion).

=end description

sub t1($x as Int) {
    is($x.WHAT, Int, 'object bound .WHATs to the right thing');
    #?rakudo todo 'nom regression'
    is($x,      1,   'object bound was coerced to the right value');
}
t1(4/3);

sub t2(Rat $x as Int) {
    is($x.WHAT, Int, 'object bound .WHATs to the right thing');
    #?rakudo todo 'nom regression'
    is($x,      2,   'object bound was coerced to the right value');
}
t2(7/3);
dies_ok { t2('omg hedgehog!') }, 'Type checks still enforced';

# vim: ft=perl6
