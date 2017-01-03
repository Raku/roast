use Test;

use lib '.';

plan 4;

# RT #128516
#?rakudo.jvm skip 'StackOverflowError, RT #128516'
{
    my class Foo {
        has $.a = Metamodel::ClassHOW.new_type(name => "Bar");
        method comp { $!a.^compose }
    }
    my $obj = Foo.new; 
    lives-ok { $obj.comp; $obj.gist },
        'Storing a meta-object in an attribute then composing/gisting works out';
}

# RT #125135
{
    use t::spec::S12-meta::TestHOW;

    class TestClass {
        method one {}
        method two {}
        method three {}
    }

    my $tc = TestClass.new;
    my $err = 'Has the wrong block stolen the dispatcher';
    ok $tc.can('one'),  $err ~ ' - 1';
    ok $tc.can('two'),  $err ~ ' - 2';
    ok $tc.can('three'),$err ~ ' - 3';
}
