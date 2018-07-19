use v6.d.PREVIEW;
use Test;

# This file is for various 6.d-specific tests that require the use of `v6.d.PREVIEW` pragma.
# They might be rearranged into other files in the future, but for now, keeping them in this
# file avoids creating a ton of `-6.d.t` files for the sake of single tests.

plan 1;
throws-like ｢use v6.d.PREVIEW; sub foo:sym<z> {}｣, X::Syntax::Reserved,
    ':sym<> token is reserved on subs in 6.d';

# vim: expandtab shiftwidth=4 ft=perl6
