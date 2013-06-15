use v6;
use MONKEY_TYPING;

use Test;

# L<S11/Compile-time Importation>

plan 8;

# test that 'use' imports class names defined in importet packages

use t::spec::packages::UseTest;

ok Stupid::Class.new(), 'can instantiate object of "imported" class';

{
    my $o = Stupid::Class.new(attrib => 'a');
    is $o.attrib, 'a', 'can access attribute';
    is $o.getter, 'a', 'can access method';
    $o.setter('b');
    is $o.attrib, 'b', 'can set through setter';
    lives_ok { $o.attrib = 'c' }, 'can set trough assignment';
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
# RT #73886
{
    BEGIN { @*INC.unshift: 't/spec/packages' }
    class MethodLoadingTest {
        method doit {
            use Foo;
            Foo.new.foo();
        }
    }
    is MethodLoadingTest.doit(), 'foo', 'can load class from inside a method';

}

# vim: ft=perl6
