use Test;

use lib $*PROGRAM.parent(2).add("packages/S12-meta/lib");

plan 7;

# https://github.com/Raku/old-issue-tracker/issues/5411
{
    my class Foo {
        has $.a = Metamodel::ClassHOW.new_type(name => "Bar");
        method comp { $!a.^compose }
    }
    my $obj = Foo.new;
    lives-ok { $obj.comp; $obj.gist },
        'Storing a meta-object in an attribute then composing/gisting works out';
}

# https://github.com/Raku/old-issue-tracker/issues/4228
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

# https://github.com/rakudo/rakudo/issues/2607
{
    my $inner = Metamodel::ClassHOW.new_type(name => 'Inner');
    $inner.^compose;

    my $outer = Metamodel::ClassHOW.new_type(name => 'Outer');
    my $attr = Attribute.new(name => '$!inner', type => $inner, package => $outer, :has_accessor);
    $outer.^add_attribute($attr);
    $outer.^compose;

    lives-ok { $outer.new(inner => $inner.new) }, 'Runtime created classes can be used as attributes';
}

# https://github.com/rakudo/rakudo/issues/4571
{
    my class ASNType {
        has $.type is rw;
    }
    my $new-type = Metamodel::ClassHOW.new_type(name => 'LDAPMessage');
    my $attribute-type = ASNType.new(type => Int);
    my $attr = Attribute.new:
        name => '$!protocol-op',
        type => $attribute-type.type,
        package => $new-type,
        :has_accessor;
    $new-type.^add_attribute($attr);
    $new-type.^compose;
    lives-ok { $new-type.new },
        'Can construct type with attribute whose type was from an rw accessor';
}

# vim: expandtab shiftwidth=4
