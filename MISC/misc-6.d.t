use v6.d;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

# This file is for various 6.d-specific tests that require the use of `v6.d` pragma.
# They might be rearranged into other files in the future, but for now, keeping them in this
# file avoids creating a ton of `-6.d.t` files for the sake of single tests.

plan 7;

group-of 6 => ':sym<> colonpair on subroutine names is reserved' => {
    throws-like 'use v6.d; sub meow:sym<bar> {}', X::Syntax::Reserved, ':sym<...>';
    throws-like 'use v6.d; sub meow:sym«bar» {}', X::Syntax::Reserved, ':sym«...»';
    throws-like 'use v6.d; sub meow:foo<bar>:sym<bar> {}', X::Syntax::Reserved,
        ':foo<bar>:sym<...>';
    throws-like 'use v6.d; sub meow:foo<bar>:sym«bar» {}', X::Syntax::Reserved,
        ':foo<bar>:sym«...»';
    throws-like 'use v6.d; sub meow:sym<bar>:foo<bar> {}', X::Syntax::Reserved,
        ':sym<...>:foo<bar>';
    throws-like 'use v6.d; sub meow:sym«bar»:foo<bar> {}', X::Syntax::Reserved,
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
        use v6.d;
        .say for lines;
        sub MAIN(*@args) {
            .say for lines;
        }
    ｣,
    "blah\nbleh\nbloh", :@args, {
        :err(''), :0status, :out("THE\nFILES\nCONTENT\nblah\nbleh\nbloh\n"),
    }, 'MAIN is an only sub';

    is_run ｢
        use v6.d;
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
        use v6.d;
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
    use v6.d;
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

group-of 3 => 'smiley constraints default to type object without smiley' => {
    group-of 14 => ':D' => {
        # XXX TODO: spec enums. POV currently blocked by
        # https://github.com/rakudo/rakudo/issues/2297
        is-eqv (my Int:D constant \a .= new: 42), 42, 'sigilless-constant';
        is-eqv (my Int:D constant $  .= new: 42), 42, '$-constant';

        is-eqv (my Int:D \b .= new: 42), 42, 'sigilless-variable';
        is-eqv (my Int:D $  .= new: 42), 42, '$-variable';
        is-eqv (my Int:D @)[^3],    (Int, Int, Int), ｢@-variable's holes｣;
        is-eqv (my Int:D %)<a b c>, (Int, Int, Int), ｢%-variable's missing keys｣;

        is-eqv my class { has Int:D $.v .= new: 42 }.new.v, 42,              '$ attribute';
        is-eqv my class { has Int:D @.v }.new.v[^3],        (Int, Int, Int), '@ attribute';
        is-eqv my class { has Int:D %.v }.new.v<a b c>,     (Int, Int, Int), '% attribute';

        is-eqv ->   Int:D @v  { @v[^3]    }(my Int:D @), (Int, Int, Int), '@ param in block';
        is-eqv ->   Int:D %v  { %v<a b c> }(my Int:D %), (Int, Int, Int), '% param in block';
        is-eqv sub (Int:D @v) { @v[^3]    }(my Int:D @), (Int, Int, Int), '@ param in sub';
        is-eqv sub (Int:D %v) { %v<a b c> }(my Int:D %), (Int, Int, Int), '% param in sub';

        my Int:D &foo = sub (--> Int:D) {};
        is-eqv &foo.of, Int:D, 'parametarized Callables are parametarized with smiley';
    }

    group-of 14 => ':U' => {
        # XXX TODO: spec enums. POV currently blocked by
        # https://github.com/rakudo/rakudo/issues/2297
        is-eqv (my Int:U constant \a .= self), Int, 'sigilless-constant';
        is-eqv (my Int:U constant $  .= self), Int, '$-constant';

        is-eqv (my Int:U \b .= self), Int, 'sigilless-variable';
        is-eqv (my Int:U $  .= self), Int, '$-variable';
        is-eqv (my Int:U @)[^3],    (Int, Int, Int), ｢@-variable's holes｣;
        is-eqv (my Int:U %)<a b c>, (Int, Int, Int), ｢%-variable's missing keys｣;

        is-eqv my class { has Int:U $.v .= self }.new.v, Int,             '$ attribute';
        is-eqv my class { has Int:U @.v }.new.v[^3],     (Int, Int, Int), '@ attribute';
        is-eqv my class { has Int:U %.v }.new.v<a b c>,  (Int, Int, Int), '% attribute';

        #?rakudo 4 skip 'crashes https://github.com/rakudo/rakudo/issues/2298'
        is-eqv ->   Int:U @v  { @v[^3]    }(my Int:U @), (Int, Int, Int), '@ param in block';
        is-eqv ->   Int:U %v  { %v<a b c> }(my Int:U %), (Int, Int, Int), '% param in block';
        is-eqv sub (Int:U @v) { @v[^3]    }(my Int:U @), (Int, Int, Int), '@ param in sub';
        is-eqv sub (Int:U %v) { %v<a b c> }(my Int:U %), (Int, Int, Int), '% param in sub';

        my Int:U &foo = sub (--> Int:U) {};
        is-eqv &foo.of, Int:U, 'parametarized Callables are parametarized with smiley';
    }

    group-of 14 => ':_' => {
        # N.B.: The `:_` is the default smiley and some implementations ignore it entirely
        # after parsing. Thus, this group of tests largely exists for completeness and possible
        # bug coverage rather than trying to spec for some behaviour that
        # isn't present without smileys.

        # XXX TODO: spec enums. POV currently blocked by
        # https://github.com/rakudo/rakudo/issues/2297
        is-eqv (my Int:_ constant \a .= new: 42), 42, 'sigilless-constant';
        is-eqv (my Int:_ constant $  .= new: 42), 42, '$-constant';

        is-eqv (my Int:_ \b .= new: 42), 42, 'sigilless-variable';
        is-eqv (my Int:_ $  .= new: 42), 42, '$-variable';
        is-eqv (my Int:_ @)[^3],    (Int, Int, Int), ｢@-variable's holes｣;
        is-eqv (my Int:_ %)<a b c>, (Int, Int, Int), ｢%-variable's missing keys｣;

        is-eqv my class { has Int:_ $.v .= new: 42 }.new.v, 42,              '$ attribute';
        is-eqv my class { has Int:_ @.v }.new.v[^3],        (Int, Int, Int), '@ attribute';
        is-eqv my class { has Int:_ %.v }.new.v<a b c>,     (Int, Int, Int), '% attribute';

        is-eqv ->   Int:_ @v  { @v[^3]    }(my Int:_ @), (Int, Int, Int), '@ param in block';
        is-eqv ->   Int:_ %v  { %v<a b c> }(my Int:_ %), (Int, Int, Int), '% param in block';
        is-eqv sub (Int:_ @v) { @v[^3]    }(my Int:_ @), (Int, Int, Int), '@ param in sub';
        is-eqv sub (Int:_ %v) { %v<a b c> }(my Int:_ %), (Int, Int, Int), '% param in sub';

        my Int:_ &foo = sub (--> Int:_) {};
        is-eqv &foo.of, Int:_, 'parametarized Callables are parametarized with smiley';
    }
}

lives-ok { for ^1000 { my $z = 42; start { $z.abs } }; sleep .3 },
    'no crashes when accessing outer lexicals';

# vim: expandtab shiftwidth=4
