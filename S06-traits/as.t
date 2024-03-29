use Test;

plan 5;

=begin description

Testing coercion types.

=end description

sub t1(Int() $x) is test-assertion {
    is($x.WHAT.gist, '(Int)', 'object bound .WHATs to the right thing');
    is($x,           1,       'object bound was coerced to the right value');
}
t1(4/3);

sub t2(Int(Rat) $x) is test-assertion {
    is($x.WHAT.gist, '(Int)', 'object bound .WHATs to the right thing');
    is($x,           2,       'object bound was coerced to the right value');
}
t2(7/3);
dies-ok { EVAL("t2('omg hedgehog!')") }, 'Type checks still enforced';

# vim: expandtab shiftwidth=4
