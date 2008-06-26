use v6;

use Test;

=begin description

Block tests

This covers anonymous blocks and subs, as well as pointy blocks
(with and without args) and bare blocks. 

L<S06/"Blocks">
L<S04/"The Relationship of Blocks and Declarations">

=end description

plan 32;

# L<S06/"Anonymous subroutines">
# anon blocks
my $anon_sub = sub { 1 };
isa_ok($anon_sub, Sub);
is($anon_sub(), 1, 'sub { } works');

my $anon_sub_w_arg = sub ($arg) { 1 + $arg };
isa_ok($anon_sub_w_arg, Sub);
is($anon_sub_w_arg(3), 4, 'sub ($arg) {} works');

# L<S06/"Blocks">
# anon blocks
my $anon_block = { 1 };
#?rakudo todo 'type Block for blocks'
isa_ok($anon_block, Block);
is($anon_block(), 1, '{} <anon block> works');

# L<S06/""Pointy blocks"">
#?rakudo skip "parse failure: pointy block as an expression"
{ 
    # pointy subs
    my $pointy_block = -> { 1 };
    isa_ok($pointy_block, 'Block');
    is($pointy_block(), 1, '-> {} <"pointy" block> works');

    my $pointy_block_w_arg = -> $arg { 1 + $arg };
    isa_ok($pointy_block_w_arg, 'Block');
    is($pointy_block_w_arg(3), 4, '-> $arg {} <"pointy" block w/args> works');

    my $pointy_block_w_multiple_args = -> $arg1, $arg2 { $arg1 + $arg2 };
    isa_ok($pointy_block_w_multiple_args, 'Block');
    is($pointy_block_w_multiple_args(3, 4), 7, '-> $arg1, $arg2 {} <"pointy" block w/multiple args> works');

    my $pointy_block_nested = -> $a { -> $b { $a + $b }};
    isa_ok($pointy_block_nested, Block);
    isa_ok($pointy_block_nested(5), Block);
    is $pointy_block_nested(5)(6), 11, '-> $a { -> $b { $a+$b }} nested <"pointy" block> works';
}

# L<S06/"Blocks">
# bare blocks

my $foo;
{$foo = "blah"};
is($foo, "blah", "lone block actually executes it's content");

my $foo2;
{$foo2 = "blah"};
is($foo2, "blah", "lone block w/out a semicolon actually executes it's content");

# XXX if this test is correct, it certainly needs a smartlink 
my $foo3;
({$foo3 = "blah"});
#?pugs eval "bug"
#?rakudo todo "unknown"
ok(!defined($foo3), "block enclosed by parentheses should not auto-execute (1)", );

my $foo4;
({$foo4 = "blah"},);
ok(!defined($foo4), "block enclosed by parentheses should not auto-execute (2)");

my $one;
my $two;
# The try's here because it should die: $foo{...} should only work if $foo isa
# Hash (or sth. which provides appropriate tieing/&postcircumfix:<{
# }>/whatever, but a Code should surely not support hash access).
# Additionally, a smart compiler will detect thus errors at compile-time, so I
# added an eval().  --iblech
try { eval '0,{$one = 1}{$two = 2}' };
is($one, undef, 'two blocks ({} {}) no semicolon after either,.. first block does not execute');
#?rakudo todo 'blocks as subscripts (?)'
is($two, 2, '... but second block does (parsed as hash subscript)');

my $one_a;
my $two_a;
{$one_a = 1}; {$two_a = 2}
is($one_a, 1, '... two blocks ({}; {}) semicolon after the first only,.. first block does execute');
is($two_a, 2, '... and second block does too');

my $one_b;
my $two_b;
{
    $one_b = 1
}
{
    $two_b = 2
};
is($one_b, 1, '... two stand-alone blocks ({\n...\n}\n{\n...\n}),.. first block does execute');
is($two_b, 2, '... and second block does too');

my $one_c;
my $two_c;
{$one_c = 1}; {$two_c = 2};
is($one_c, 1, '... two blocks ({}; {};) semicolon after both,.. first block does execute');
is($two_c, 2, '... and second block does too');

sub f { { 3 } }
is(f(), 3, 'bare blocks immediately runs even as the last statement');
#?rakudo 4 skip 'calling postcircumfix:<()> with a dot'
is((sub { { 3 } }).(), 3, 'ditto for anonymous subs');
is((sub { { { 3 } } }).(), 3, 'ditto, even if nested');
dies_ok({(sub { { $^x } }).()}, 'implicit params become errors');
isnt((sub { -> { 3 } }).(), 3, 'as are pointies');
