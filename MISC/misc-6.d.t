use v6.d.PREVIEW;
use Test;

# This file is for various 6.d-specific tests that require the use of `v6.d.PREVIEW` pragma.
# They might be rearranged into other files in the future, but for now, keeping them in this
# file avoids creating a ton of `-6.d.t` files for the sake of single tests.

plan 1;

subtest ':sym<> colonpair on subroutine names is reserved' => {
    plan 6;
    throws-like 'use v6.d.PREVIEW; sub meow:sym<bar> {}', X::Syntax::Reserved, ':sym<...>';
    throws-like 'use v6.d.PREVIEW; sub meow:sym«bar» {}', X::Syntax::Reserved, ':sym«...»';
    throws-like 'use v6.d.PREVIEW; sub meow:foo<bar>:sym<bar> {}', X::Syntax::Reserved,
        ':foo<bar>:sym<...>';
    throws-like 'use v6.d.PREVIEW; sub meow:foo<bar>:sym«bar» {}', X::Syntax::Reserved,
        ':foo<bar>:sym«...»';
    throws-like 'use v6.d.PREVIEW; sub meow:sym<bar>:foo<bar> {}', X::Syntax::Reserved,
        ':sym<...>:foo<bar>';
    throws-like 'use v6.d.PREVIEW; sub meow:sym«bar»:foo<bar> {}', X::Syntax::Reserved,
        ':sym«...»:foo<bar>';
}

# vim: expandtab shiftwidth=4 ft=perl6
