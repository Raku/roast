use v6;


use Test;

plan 6;

# L<S06/Slurpy block/>

sub foo (Code *$block) {
    return $block.();
}

is(foo():{ "foo" }, 'foo', 'Code *$block - 1');
is(foo():{ 0 }, 0, 'Code *$block - 2');

sub bar (*&block) {
    return &block.();
}

is(bar():{ "bar" }, 'bar', '*&block - 1');
is(bar():{ 0 }, 0, '*&block - 2');

is(foo():{ "foo" }, bar():{ "foo" }, 'Code *$block == *&block - 1');
is(foo():{ 0 }, bar():{ 0 }, 'Code *$block == *&block - 2');

# vim: expandtab shiftwidth=4
