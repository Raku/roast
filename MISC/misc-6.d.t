use v6.d.PREVIEW;
use lib $?FILE.IO.parent(2).add: 'packages';
use Test;
use Test::Util;

# This file is for various 6.d-specific tests that require the use of `v6.d.PREVIEW` pragma.
# They might be rearranged into other files in the future, but for now, keeping them in this
# file avoids creating a ton of `-6.d.t` files for the sake of single tests.

plan 5;

group-of 6 => ':sym<> colonpair on subroutine names is reserved' => {
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

group-of 5 => '$*ARGFILES is set to $*IN inside sub MAIN' => {
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

group-of 8 => 'native num defaults to 0e0' => {
    my num $x;
    is-deeply $x, 0e0, '`my` variable';
    is-deeply my class { has num $.z }.new.z, 0e0, 'class attribute';
    is-deeply my role  { has num $.z }.new.z, 0e0, 'role attribute';
    is-deeply my class { submethod z(num $v?) { $v } }.new.z, 0e0, 'submethod param';
    is-deeply my class { method    z(num $v?) { $v } }.new.z, 0e0, 'method param';
    is-deeply sub (num $v?) { $v }(), 0e0, 'sub param';
    is-deeply ->   num $v?  { $v }(), 0e0, 'block param';
    my num @a; is-deeply @a[0], 0e0, 'native num array unset element';
}

is_run ｢
    use v6.d.PREVIEW;
    # override any possible deprecation silencers implementations may have
    BEGIN %*ENV<RAKUDO_NO_DEPRECATIONS> = 0;
    my $x = 42;     undefine $x;
    my @y = 42;     undefine @y;
    my %z = :42foo; undefine %z;
    ($x || @y || %z) and die "failed";
    print 'pass';
｣, {:out<pass>, :err{.contains: 'deprecat'}, :0status},
    'use of `undefine` issues deprecation warning in 6.d';

group-of 6 => '$()/@()/%() have no magick' => {
    'ab' ~~ /(.) $<foo>=(.)/;

    # NOTE: these tests are white-space sensitive. There should be NO whitespace
    # within the $(), @(), and %() constructs.
    is-eqv $(), (), '$() is a List';
    is-eqv ($(), $(), $()).flat, ((), (), ()).Seq, '$() is a containerized List';

    is-eqv @(), (), '@() is a List';
    is-eqv (@(), @(), @()).flat, ().Seq, '@() is NOT a containerized List';

    is-eqv %(), {}, '%() is a Hash';
    is-eqv (%(), %(), %()).flat, ().Seq, '@() is NOT a containerized Hash';
}

# vim: expandtab shiftwidth=4 ft=perl6
