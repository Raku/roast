use Test;

use lib $?FILE.IO.parent(2).add("packages/S12-meta/lib");

plan 5;

# RT #128516
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
    use TestHOW;

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

# GH #2602
{
    my $GH2602 = Metamodel::ClassHOW.new_type(name => "GH2602");
    $GH2602.^compose;
    ok $GH2602.new.WHAT ~~ $GH2602,
        'Smartmatch returns True for a scalar with a run-time created class and an instance of the class';
}
