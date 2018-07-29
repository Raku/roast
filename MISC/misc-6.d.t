use v6.d.PREVIEW;
use lib $?FILE.IO.parent(2).add: 'packages';
use Test;
use Test::Util;

# This file is for various 6.d-specific tests that require the use of `v6.d.PREVIEW` pragma.
# They might be rearranged into other files in the future, but for now, keeping them in this
# file avoids creating a ton of `-6.d.t` files for the sake of single tests.

plan 2;

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

subtest '$*ARGFILES is set to $*IN inside sub MAIN' => {
    plan 5;
    my @args = <THE FILES CONTENT>.map: {make-temp-file :$^content}

    is_run ｢
        use v6.c;
        sub MAIN(*@args) {
            .say for lines;
        }
    ｣,
    "blah\nbleh\nbloh", :@args, {
        :err(''), :0status, :out("THE\nFILES\nCONTENT\n"),
    }, 'inside MAIN in 6.c language (with @*ARGS content)';

    is_run ｢
        use v6.c;
        sub MAIN(*@args) {
            .say for lines;
        }
    ｣,
    "blah\nbleh\nbloh", {
        :err(''), :0status, :out("blah\nbleh\nbloh\n"),
    }, 'inside MAIN in 6.c language (without @*ARGS content)';

    is_run ｢
        use v6.d.PREVIEW;
        .say for lines;
        sub MAIN(*@args) {
            .say for lines;
        }
    ｣,
    "blah\nbleh\nbloh", :@args, {
        :err(''), :0status, :out("THE\nFILES\nCONTENT\nblah\nbleh\nbloh\n"),
    }, 'MAIN is an only sub';

    is_run ｢
        use v6.d.PREVIEW;
        .say for lines;
        multi MAIN($, $, $) {
            .say for lines;
        }
        multi MAIN(|) { die }
    ｣,
    "blah\nbleh\nbloh", :@args, {
        :err(''), :0status, :out("THE\nFILES\nCONTENT\nblah\nbleh\nbloh\n"),
    }, 'MAIN is a multi sub';

    is_run ｢
        use v6.d.PREVIEW;
        .say for lines;
    ｣,
    "blah\nbleh\nbloh", :@args, {
        :err(''), :0status, :out("THE\nFILES\nCONTENT\n"),
    }, 'no MAIN';
}

# vim: expandtab shiftwidth=4 ft=perl6
