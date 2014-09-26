use v6;

use Test;

=begin description

Block tests

This covers anonymous blocks and subs, as well as pointy blocks
(with and without args) and bare blocks.

=end description

plan 42;

# L<S04/"The Relationship of Blocks and Declarations">
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
isa_ok($anon_block, Block);
is($anon_block(), 1, '{} <anon block> works');

# RT #64844
#?niecza skip "Exception NYI"
{
    EVAL '$anon_block( 1 )';
    #?rakudo todo 'Parrot support for zero-arg subs?'
    ok $! ~~ Exception, 'too many parameters';

    if $! !~~ Exception {
        skip q{tests don't work if previous test fails}, 2;
    }
    else {
        my $errmsg = ~$!;

        EVAL '$anon_block( foo => "RT #64844" )';
        ok $! ~~ Exception, 'too many parameters';
        is ~$!, $errmsg, 'same error for named param as positional';
    }
}

# L<S06/""Pointy blocks"">
{
    # pointy subs
    my $pointy_block = -> { 1 };
    isa_ok($pointy_block, Block);
    is($pointy_block(), 1, '-> {} <"pointy" block> works');

    my $pointy_block_w_arg = -> $arg { 1 + $arg };
    isa_ok($pointy_block_w_arg, Block);
    is($pointy_block_w_arg(3), 4, '-> $arg {} <"pointy" block w/args> works');

    my $pointy_block_w_multiple_args = -> $arg1, $arg2 { $arg1 + $arg2 };
    isa_ok($pointy_block_w_multiple_args, Block);
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

my $foo4;
({$foo4 = "blah"});
ok(!defined($foo4), "block enclosed by parentheses should not auto-execute (2)");

my $one;
my $two;
# The try's here because it should die: $foo{...} should only work if $foo isa
# Hash (or sth. which provides appropriate tieing/&postcircumfix:<{
# }>/whatever, but a Code should surely not support hash access).
# Additionally, a smart compiler will detect thus errors at compile-time, so I
# added an EVAL().  --iblech
try { EVAL '0,{$one = 1}{$two = 2}' };
ok(!defined($one), 'two blocks ({} {}) no semicolon after either,.. first block does not execute');
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
#?rakudo.jvm 3 todo "?"
is(f(), 3, 'bare blocks immediately runs even as the last statement');
is((sub { { 3 } }).(), 3, 'ditto for anonymous subs');
is((sub { { { 3 } } }).(), 3, 'ditto, even if nested');
throws_like {(sub { { $^x } }).()},
  X::AdHoc,
  'implicit params become errors';
isnt((sub { -> { 3 } }).(), 3, 'as are pointies');

# RT #68116
{
    sub rt68116 { 68116 }
    is &rt68116(), 68116, 'check that sub is callable via &';
    is { &^x() }.( &rt68116 ), 68116,
        'call via { &^pos() }( &s ) works for sub';
    is -> &x { &x() }.( &rt68116 ), 68116,
        'call via -> &point { &point() }.( &s ) works for sub';
    is (sub (&x) { &x() }).( &rt68116 ), 68116,
        'call via (sub (&x) { &x() }).( &s ) works for sub';
}

#?niecza skip 'No candidates for dispatch to mone'
{
    proto mone(|) { * }
    multi mone { 'one' }
    is &mone(), 'one', 'check that mutli is callable via &';
    is { &^x() }.( &mone ), 'one',
        'call via { &^pos() }( &s ) works for multi';
    is -> &x { &x() }.( &mone ), 'one',
        'call via -> &point { &point() }.( &s ) works for multi';
    is (sub (&x) { &x() }).( &mone ), 'one',
        'call via (sub (&x) { &x() }).( &s ) works for multi';
    
}

# vim: ft=perl6
