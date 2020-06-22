use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

use lib $?FILE.IO.parent(2).add("packages/UseTest/lib");
use lib $?FILE.IO.parent(2).add("packages/FooBarBaz/lib");

use MONKEY-TYPING;

# L<S11/Compile-time Importation>

plan 10;

# test that 'use' imports class names defined in imported packages

use UseTest;

ok Stupid::Class.new(), 'can instantiate object of "imported" class';

{
    my $o = Stupid::Class.new(attrib => 'a');
    is $o.attrib, 'a', 'can access attribute';
    is $o.getter, 'a', 'can access method';
    $o.setter('b');
    is $o.attrib, 'b', 'can set through setter';
    lives-ok { $o.attrib = 'c' }, 'can set trough assignment';
    is $o.attrib, 'c', 'setting actually worked';
}

{
    augment class Stupid::Class {
        method double { $.attrib ~ $.attrib };
    }
    my $o = Stupid::Class.new( attrib => 'd' );
    is $o.double, 'dd', 'can extend "imported" class';

}

# class loading inside a method
# https://github.com/Raku/old-issue-tracker/issues/1639
{
    class MethodLoadingTest {
        method doit {
            use Foo;
            Foo.new.foo();
        }
    }
    is MethodLoadingTest.doit(), 'foo', 'can load class from inside a method';

}

# https://github.com/Raku/old-issue-tracker/issues/1642
{
    use Foo;
    lives-ok { class Bar { } }, 'declaring a class after use-ing a module (RT #73910)'
}

#?rakudo.js.browser skip "runtime time use doesn't work in the browser"
# https://github.com/Raku/old-issue-tracker/issues/4635
is_run ｢use RT126302; say "RT126302-OK"｣,
  :compiler-args['-I', $?FILE.IO.parent(2).add("packages/RT126302/lib").absolute], {
    :out(/'RT126302-OK'/),
    :err{not .contains: 'src/Perl6/World.nqp'}
    # "Perl6/World" is guts from Rakudo implementation and we check
    # the genned warnings doesn't reference any guts
  }, 'packages with private `is rw` attrs compile successfully';

# vim: expandtab shiftwidth=4
