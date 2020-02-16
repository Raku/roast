use v6;
use Test;

use experimental :cached;

plan 47;

{
    my @seen;
    sub fib(Int $x) is cached {
        @seen.push: $x;
        $x <= 1 ?? 1 !! fib($x - 1) + fib($x - 2);
    }
    is fib(9), 55, 'does fib(9) work';
    is @seen, (9,8,7,6,5,4,3,2,1,0), 'did we call them all (1)';
    is fib(10), 89, 'does fib(10) work';
    is @seen, (9,8,7,6,5,4,3,2,1,0,10), 'did we call them all (2)';
    is fib(10), 89, 'does fib(10) work';
    is @seen, (9,8,7,6,5,4,3,2,1,0,10), 'did we call them all (3)';
} #6

{
    my @seen;
    sub duh ( :$foo = 'duh', :$bar = 'doh' ) is cached {
        @seen.push: $foo, $bar;
        $foo ~ $bar;
    }
    is duh(), 'duhdoh', 'no args case(1)';
    is @seen, <duh doh>, 'did we run (1)';
    is duh(), 'duhdoh', 'no args case (2)';
    is @seen, <duh doh>, 'did we run (2)';
    is duh(:foo<foo>), 'foodoh', 'foo arg case (1)';
    is @seen, <duh doh foo doh>, 'did we run (3)';
    is duh(:foo<foo>), 'foodoh', 'foo arg case (2)';
    is @seen, <duh doh foo doh>, 'did we run (4)';
    is duh(:bar<bar>), 'duhbar', 'bar arg case (1)';
    is @seen, <duh doh foo doh duh bar>, 'did we run (5)';
    is duh(:bar<bar>), 'duhbar', 'bar arg case (2)';
    is @seen, <duh doh foo doh duh bar>, 'did we run (6)';
    is duh(:foo<foo>, :bar<bar>), 'foobar', 'foo,bar arg case (1)';
    is @seen, <duh doh foo doh duh bar foo bar>, 'did we run (7)';
    is duh(:foo<foo>, :bar<bar>), 'foobar', 'foo,bar arg case (2)';
    is @seen, <duh doh foo doh duh bar foo bar>, 'did we run (8)';
} #16

{
    my @seen;
    sub noflat (@a) is cached {
        @seen.append: @a;
        [~] @a;
    }
    my @b = <foo bar>;
    is noflat($@b), 'foobar', 'foo,bar case(1)';
    is @seen, [<foo bar>], 'did we run (1)';
    is noflat($@b), 'foobar', 'foo,bar case(2)';
    is @seen, [<foo bar>], 'did we run (2)';

    # make sure the cache key is value based
    @b.push: <baz>;
    is noflat($@b), 'foobarbaz', 'foo,bar,baz case(1)';
    is @seen, [<foo bar foo bar baz>], 'did we run (3)';
    is noflat($@b), 'foobarbaz', 'foo,bar,baz case(2)';
    is @seen, [<foo bar foo bar baz>], 'did we run (4)';
} #8

{
    my @int;
    my @str;
    proto foo (|) is cached { * }
    multi foo (Int $number) { @int.push: $number; $number }
    multi foo (Str $string) { @str.push: $string; $string }

    is foo(42), 42, 'did we get the value back (1)';
    is-deeply @int, [42], 'was the code done (1)';
    is foo(42), 42, 'did we get the value back (2)';
    # https://github.com/Raku/old-issue-tracker/issues/3463
    #?rakudo.jvm todo "is cached is only a hint"
    is-deeply @int, [42], 'was the code done (2)';

    is foo("Camelia"), "Camelia", 'did we get the value back (3)';
    is-deeply @str, [<Camelia>], 'was the code done (3)';
    is foo("Camelia"), "Camelia", 'did we get the value back (4)';
    # https://github.com/Raku/old-issue-tracker/issues/3463
    #?rakudo.jvm todo "is cached is only a hint"
    is-deeply @str, [<Camelia>], 'was the code done (4)';
} #4

lives-ok {
    my method () is cached { }
}, 'can create cached methods';

{
    my class Cached {
        has Bool:D $.modified is rw = False;

        method public($value) is cached { (state $)++ }

        method !private($value) is cached { (state $)++ }

        method ^meta($value) is cached { (state $)++ }

        proto method proto($value) is cached { (state $)++ }

        multi method multi($value) is cached { (state $)++ }

        proto method proto-and-multi($value) is cached {*}
        multi method proto-and-multi($value) is cached { (state $)++ }
    }

    my &private = Cached.^find_private_method('private');
    cmp-ok Cached.public(1), &[==], Cached.public(1),
        'public methods can cache';
    cmp-ok private(Cached, 1), &[==], private(Cached, 1),
        'private methods can cache';
    cmp-ok Cached.HOW.meta(1), &[==], Cached.HOW.meta(1),
        'metamethods can cache';
    cmp-ok Cached.proto(1), &[==], Cached.proto(1),
        'proto methods can cache';
    cmp-ok Cached.multi(1), &[==], Cached.multi(1),
        'multi methods can cache';
    cmp-ok Cached.proto-and-multi(1), &[==], Cached.proto-and-multi(1),
        'a mix of proto and multi methods can cache';

    my $cached = Cached.new;
    cmp-ok Cached.public(1), &[!==], $cached.public(1),
        'different invocants of cached methods do not share a cache';

    my $result = $cached.public: 1;
    $cached.modified = True;
    cmp-ok $result, &[==], $cached.public(1),
        'modifying the state of the invocant of a cached method does not affect its cache';
}

# vim: ft=perl6
